class Podcast < ApplicationRecord
  has_many :privileges, dependent: :delete_all
  has_many :users, through: :privileges
  has_many :recordings, dependent: :delete_all
  validates :shortname, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  after_create :schedule_render
  after_update :schedule_render
  has_one_attached :image_file do |attachable|
    attachable.variant :thumb, resize_to_limit: [100, 100]
  end

  def schedule_render
    GeneratePodcastJob.perform_later self
  end
end
