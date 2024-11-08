class TaskAssignment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  belongs_to :assigned_by, class_name: 'User'

  validates :user_id, uniqueness: { scope: :task_id, message: "User can only be assigned once per task" }
end

