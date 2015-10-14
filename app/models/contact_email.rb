class ContactEmail < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A([\w+\-].?)+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i

  validates :name, presence: true
  validates :message, presence: true

  validates :email, format: { with: VALID_EMAIL_REGEX }
end
