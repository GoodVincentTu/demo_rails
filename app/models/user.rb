class User < ApplicationRecord
  attr_accessor :reset_token
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

  def reset_token_expired?
    reset_token_sent_at < 6.hours.ago
  end
  
  def create_reset_password_token
    self.reset_token = User.new_token
    update_columns(
      reset_token_digest: User.digest(reset_token),
      reset_token_sent_at: Time.now
    )
  end

  private

    def set_default_username
      self.username = self.email.split('@')[0]
    end
end