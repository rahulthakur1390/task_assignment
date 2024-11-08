class Api::TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin, only: [:create, :assign]

  def create
    task = Task.new(task_params.merge(created_by: current_user))
    if task.save
      render json: task, status: :created
    else
      render json: { error: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def assign
    task = Task.find(params[:id])
    user = User.find(params[:user_id])

    if task && user && current_user.admin?
      task_assignment = TaskAssignment.create!(task: task, user: user, assigned_by: current_user)
      render json: task_assignment, status: :ok
    else
      render json: { error: 'Unauthorized or invalid task/user' }, status: :forbidden
    end
  end

  def assigned
    tasks = current_user.tasks
    render json: tasks, status: :ok
  end

  def complete
    task = Task.find(params[:id])

    if task && task.users.include?(current_user)
      task.update(completed: true)
      render json: task, status: :ok
    else
      render json: { error: 'Task not found or not assigned to you' }, status: :unprocessable_entity
    end
  end

  private

  def authenticate_user!
    token = request.headers['Authorization']&.split(' ')&.last
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id])
    render json: { error: 'Not authorized' }, status: :unauthorized unless @current_user
  end

  def check_admin
    render json: { error: 'Admin only' }, status: :forbidden unless current_user.admin?
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end

