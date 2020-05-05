# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  before_create :confirmation_token
  has_one :freelancer, dependent: :destroy
  has_one :client, dependent: :destroy
  has_many :job, dependent: :destroy

  ROLES = %i[visitor freelancer client admin].freeze

  def role?(role_name)
    role == role_name
  end

  def email_activate
    self.email_confirmed = true
    self.confirm_token = nil
    save!(validate: false)
  end

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  has_secure_password

  private

  def confirmation_token
    if confirm_token.blank?
      self.confirm_token = SecureRandom.urlsafe_base64.to_s
    end
  end
end
