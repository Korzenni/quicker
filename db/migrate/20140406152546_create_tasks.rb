class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.date :start_date
      t.date :end_date
      t.string :name
      t.integer :user_id
      t.integer :project_id

      t.timestamps
    end
  end
end
