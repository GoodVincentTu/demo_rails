class User < ApplicationRecord
  before_create :set_default_username
  EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: :true, uniqueness: true,
                    format: { with: EMAIL_REGEX}
  has_secure_password
  validates :password, presence: true, length: { minimum: 8 },
                       allow_nil: true

  # for forgot password feature
  class << self
    def digest(token_string)
      BCrypt::Password.create(token_string)
    end
    
    def new_token
      SecureRandom.urlsafe_base64
    end
  end


  private

    def set_default_username
      self.username = self.email.split('@')[0]
    end
end