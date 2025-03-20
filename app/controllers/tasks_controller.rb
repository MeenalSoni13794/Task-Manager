class TasksController < ApplicationController
	def index
    @tasks = if Task.feature_enabled?(:new_task_feature)
               Task.all.order(created_at: :desc)
             else
               Task.all
             end
  end

  def create
    task = Task.new(task_params)
    if task.save
      render json: task, status: :created
    else
      render json: { errors: task.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
