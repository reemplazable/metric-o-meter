# frozen_string_literal: true

class CreateStatistics < ActiveRecord::Migration[7.0]
  def change
    create_table :statistics do |t|
      t.decimal :value, null: false
      t.string :name, null: false
      t.timestamp :timestamp, null: false
      t.integer :stat_type, null: false

      t.index %i[name timestamp stat_type], unique: true
      t.index :value

      t.timestamps
    end
  end
end
