class Podcast < ApplicationRecord
  has_many :privileges, dependent: :delete_all
  has_many :users, through: :privileges
  has_many :recordings, dependent: :delete_all
  validates :shortname, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
end
