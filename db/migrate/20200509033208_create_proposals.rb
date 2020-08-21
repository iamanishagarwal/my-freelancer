# frozen_string_literal: true

class CreateProposals < ActiveRecord::Migration[6.0]
  def change
    create_table :proposals do |t|
      t.belongs_to :freelancer
      t.belongs_to :job
      t.timestamps
    end
  end
end
