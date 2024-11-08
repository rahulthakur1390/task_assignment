class Task < ApplicationRecord
  belongs_to :created_by, class_name: 'User'

  has_many :task_assignments
  has_many :users, through: :task_assignments

  validates :title, presence: true
  validates :description, presence: true
end

