class Podcast < ApplicationRecord
  has_many :privileges, dependent: :delete_all
  has_many :users, through: :privileges
  has_many :recordings, dependent: :delete_all
  validates :shortname, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  after_create :schedule_render
  after_update :schedule_render
  
  def schedule_render
    GeneratePodcastJob.perform_later self
  end
end
