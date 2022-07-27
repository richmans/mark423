class Podcast < ApplicationRecord
  has_many :user_podcasts
  has_many :podcasts, through: :user_podcasts
  validates :shortname, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
