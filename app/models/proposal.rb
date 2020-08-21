# frozen_string_literal: true

class Proposal < ApplicationRecord
  belongs_to :freelancer
  belongs_to :job
end
