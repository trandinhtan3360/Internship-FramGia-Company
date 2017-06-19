class User < ApplicationRecord
  has_many :microposts
	has_many :microposts,  dependent: :destroy
  #validates name, presence: true    # Replace FILL_IN with the right code.
  #validates email, presence: true    # Replace FILL_IN with the right code.
  attr_accessor :remember_token, :activation_token
  before_save   :downcase_email
   before_create :create_activation_digest
  before_save { email.downcase! }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 }

  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  class << self
    def digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
    end

  # Returns a random token.
    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def remember
    remember_token = new_token
    update_attribute(:remember_digest, digest(remember_token))
  end

  def authenticated?(attribute, token)
    digest = self.send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

private
# Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end
end
