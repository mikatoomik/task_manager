class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [ :edit, :update, :destroy, :toggle ]

  def new
    @task = @list.tasks.new
  end

  def create
    @task = @list.tasks.new(task_params)
    if @task.save
      redirect_to list_path(@list), notice: t("tasks.notices.created")
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to list_path(@list), notice: t("tasks.notices.updated")
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to list_path(@list), notice: t("tasks.notices.destroyed")
  end

  def toggle
    @task.update(completed: !@task.completed)
    redirect_to list_path(@list)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = @list.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description, :completed, :priority)
  end
end
