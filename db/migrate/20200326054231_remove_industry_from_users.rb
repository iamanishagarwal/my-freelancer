# frozen_string_literal: true

class RemoveIndustryFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :industry, :string
  end
end
