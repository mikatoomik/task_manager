# frozen_string_literal: true

class TasksController < ApplicationController
  before_action :set_list
  before_action :set_task, only: [:edit, :update, :destroy, :toggle]

  def new
    @task = @list.tasks.new
  end

  def edit
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("task_card_#{@task.id}", partial: "tasks/form",
                                                                           locals: { task: @task })
      end
      format.html
    end
  end

  def create
    @task = @list.tasks.new(task_params)

    if @task.save
      @new_task = @list.tasks.new # tâche vide pour le formulaire
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.append("list_tasks_#{@list.id}", partial: "tasks/card", locals: { list: @list, task: @task }),
            turbo_stream.replace("new_task_form", partial: "tasks/form", locals: { list: @list, task: @new_task })
          ]
        end
        format.html { redirect_to list_path(@list), notice: t("tasks.notices.created") }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("new_task_form", partial: "tasks/form", locals: { list: @list, task: @task })
        end
        format.html { render :new }
      end
    end
  end


  def update
    if @task.update(task_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("task_card_#{@task.id}", partial: "tasks/card",
                                                                             locals: { list: @list, task: @task })
        end
        format.html
      end
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove("task_card_#{@task.id}") }
      format.html { redirect_to list_path(@list), notice: t("tasks.notices.destroyed") }
    end
  end

    def toggle
      @task.update_column(:completed, !@task.completed)

      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("task_card_#{@task.id}", partial: "tasks/card", locals: { list: @list, task: @task }),
            turbo_stream.replace("list_progress_#{@list.id}", partial: "lists/progress", locals: { list: @list })
          ]
        end
        format.html { redirect_to list_path(@list) }
    end
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = @list.tasks.find(params[:id])
  end

  def task_params
    params.expect(task: [:title, :description, :completed, :priority])
  end
end
