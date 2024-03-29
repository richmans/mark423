class Podcast < ApplicationRecord
  has_many :privileges, dependent: :delete_all
  has_many :users, through: :privileges
  has_many :recordings, dependent: :destroy
  validates :shortname, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validate :validate_category
  attr_accessor :skip_callbacks

  has_one_attached :image_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  has_one_attached :rss_file
  has_one_attached :js_file

  after_commit :schedule_render, on: [:create, :update],  unless: :skip_callbacks
  #after_touch :schedule_render, unless: :skip_callbacks
  after_initialize :empty_category

  def empty_category
    if self.category.nil?
      self.category = '{}'
    end
  end

  def visible_recordings
    self.recordings.where(published: true).order(recorded_at: :desc).limit(self.max_recordings)
  end

  def self.categories
    return @categories unless @categories.nil?
    filename = File.join(Rails.root, 'config', 'categories.yml')
    @categories = YAML.load(File.open(filename))
    @categories
  end

  def validate_category
    begin
      JSON.parse category
    rescue
      errors.add :category, "Invalid JSON string"
    end
    true
  end

  def parsed_category
    JSON.parse category rescue {}
  end     

  def each_category
    parsed_category.each_pair do |category, sub_categories|
      yield(category, sub_categories)
    end
  end

  def dir
    "#{Rails.application.config.podcast_host}/#{self.shortname}/"
  end

  def rss_link
    self.dir + "podcast.rss"
  end

  def js_link
    self.dir + "podcast.js"
  end

  def picture_link
    self.dir + "podcast." + self.image_file.filename.extension
  end

  def schedule_render
    logger.info("SCHEDULING RENDER")
    GeneratePodcastJob.perform_later self, self.updated_at
  end

  def self.languages
    {
      :en => "English",
      :nl => "Nederlands",
      :de => "Deutsch"
    }
  end
end
