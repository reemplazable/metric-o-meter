# frozen_string_literal: true

class CreateMeasures < ActiveRecord::Migration[7.0]
  def change
    create_table :measures do |t|
      t.timestamp :timestamp, null: false
      t.string :name, null: false
      t.decimal :value, null: false

      t.timestamps
    end
  end
end
