# frozen_string_literal: true

class Freelancer < ApplicationRecord
  belongs_to :user
  has_many :proposals, dependent: :destroy
  has_many :jobs, through: :proposals

  validates :user_id, presence: true, uniqueness: true
  validates :industry, presence: true
  validates :qualification, presence: true
  validates :experience, presence: true
  mount_uploader :avatar, AvatarUploader
  serialize :avatar, JSON # If you use SQLite, add this line.
end
