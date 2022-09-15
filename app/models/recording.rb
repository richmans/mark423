class Recording < ApplicationRecord
  belongs_to :podcast
  has_one_attached :audio_file
  has_one_attached :image_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end
  after_destroy :schedule_render
  after_update :schedule_render
  after_create :schedule_render
  before_create :set_filename
  before_update :set_filename

  def set_filename
    self.filename = get_filename()
    if self.audio_file.attached?
      self.audio_file.blob.update(filename: filename)
    end
  end

  def get_filename()
    uncounted_filename  = speaker[0..20].parameterize + "-" unless speaker.nil?
    uncounted_filename += theme[0..30].parameterize + "-" unless theme.nil?
    uncounted_filename += recorded_at.strftime("%Y%m%d")
    new_filename = uncounted_filename
    counter = 1
    while Recording.where(filename: new_filename).where.not(id: id).any? do
      counter += 1
      new_filename = "#{uncounted_filename}-#{counter}"
    end
    new_filename
  end

  def audio_link
    self.podcast.dir + self.filename + '.mp3'
  end

  def image_link
    self.podcast.dir + self.filename + '.jpg'
  end

  def duration
    return nil unless self.publishable
    return self.audio_file.metadata['duration']
  end

  def publishable
    return self.audio_file.attached? && self.audio_file.analyzed?
  end
  
  def schedule_render
    self.podcast.schedule_render
  end
end
