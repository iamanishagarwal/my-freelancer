# frozen_string_literal: true

class RemoveExperienceFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :experience, :string
  end
end
