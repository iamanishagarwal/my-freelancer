# frozen_string_literal: true

class CreateFreelancers < ActiveRecord::Migration[6.0]
  def change
    create_table :freelancers do |t|
      t.integer :user_id
      t.string :industry
      t.string :experience
      t.string :qualification
      t.string :avatar
      t.timestamps
    end
  end
end
