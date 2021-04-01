class CreateSchedules < ActiveRecord::Migration[6.1]
  def change
    create_table :schedules do |t|
      t.datetime :initial_time,   null: false
      t.datetime :final_time,     null: false
      t.integer :user_id,         null: false
      t.text :description,        default: ""
      t.timestamps
    end
    add_foreign_key :schedules, :users, index: true
    add_index :schedules, :initial_time
  end
end
