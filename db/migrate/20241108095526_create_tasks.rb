class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.boolean :completed
      t.references :created_by, null: false, foreign_key: true

      t.timestamps
    end
  end
end
