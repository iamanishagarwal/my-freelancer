# frozen_string_literal: true

class RemoveEducationFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :education, :string
  end
end
