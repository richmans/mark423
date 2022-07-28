class Podcast < ApplicationRecord
  has_many :privileges
  has_many :podcasts, through: :privileges
  validates :shortname, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
