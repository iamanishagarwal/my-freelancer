# frozen_string_literal: true

class CreateJobs < ActiveRecord::Migration[6.0]
  def change
    create_table :jobs do |t|
      t.integer :user_id
      t.string :title
      t.string :description
      t.string :document
      t.timestamps
    end
  end
end
