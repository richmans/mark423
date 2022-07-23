class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates_format_of :email, with: URI::MailTo::EMAIL_REGEXP
  validates :full_name, presence: true
  before_validation :downcase_email

  def downcase_email
    email.downcase!
  end
end
