class User < ApplicationRecord
  has_secure_password

  enum role: { admin: 0, member: 1 }

  has_many :task_assignments
  has_many :tasks, through: :task_assignments

  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
