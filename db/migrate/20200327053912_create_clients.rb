# frozen_string_literal: true

class CreateClients < ActiveRecord::Migration[6.0]
  def change
    create_table :clients do |t|
      t.integer :user_id
      t.string :industry
      t.string :avatar
      t.timestamps
    end
  end
end
