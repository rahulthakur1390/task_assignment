class CreateTaskAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :task_assignments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :task, null: false, foreign_key: true
      t.references :assigned_by, null: false, foreign_key: true

      t.timestamps
    end
  end
end
