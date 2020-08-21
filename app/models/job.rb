# frozen_string_literal: true

class Job < ApplicationRecord
  belongs_to :user
  has_many :proposals, dependent: :destroy
  has_many :freelancers, through: :proposals

  validates :user_id, presence: true
  validates :title, presence: true, length: { minimum: 3, maximum: 50 }
  validates :description, presence: true, length: { minimum: 10 }

  mount_uploader :document, DocumentUploader
end
