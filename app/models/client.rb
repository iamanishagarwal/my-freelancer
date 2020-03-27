# frozen_string_literal: true

class Client < ApplicationRecord
  belongs_to :user

  validates :user_id, presence: true, uniqueness: true
  validates :industry, presence: true
  mount_uploader :avatar, AvatarUploader
  serialize :avatar, JSON # If you use SQLite, add this line.
end
