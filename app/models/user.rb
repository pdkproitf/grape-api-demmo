class User < ApplicationRecord
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :omniauthable, :confirmable
  include DeviseTokenAuth::Concerns::User
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  has_many  :products, dependent: :destroy

  validates :email, presence: true, length: {maximum: 255},
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: {case_sensitive: false}

  validates :password, presence: true, length: {minimum: 6}, allow_nil: true

  before_save   :downcase_email
  # after_create :send_confirmation_email

  def self.test
    Devise::devise_parameter_sanitizer
  end

  private
  # Converts email to all lower-case
  def downcase_email
    self.email = email.downcase
  end
end
