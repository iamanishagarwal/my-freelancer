# frozen_string_literal: true

class Freelancer < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true
  validates :industry, presence: true
  validates :qualification, presence: true
  validates :experience, presence: true
  mount_uploader :avatar, AvatarUploader
  serialize :avatar, JSON # If you use SQLite, add this line.
end
