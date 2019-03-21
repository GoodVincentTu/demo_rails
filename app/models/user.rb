class User < ApplicationRecord

  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: :true, uniqueness: true,
                    format: { with: EMAIL_REGEX}
  validates :password, presence: true, length: { minimum: 8 }
  has_secure_password

  class << self
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
end