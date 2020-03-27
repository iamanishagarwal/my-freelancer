# frozen_string_literal: true

class User < ApplicationRecord
  before_save { self.email = email.downcase }
  has_one :freelancer, dependent: :destroy
  has_one :client, dependent: :destroy

  ROLES = %i[visitor freelancer client admin].freeze

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :name, presence: true, length: { minimum: 3, maximum: 50 }
  has_secure_password
end
