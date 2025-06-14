# frozen_string_literal: true

class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.includes(:tasks).find(params[:id])

    @tasks = case params[:status]
             when "completed"  then @list.tasks.completed
             when "incomplete" then @list.tasks.incomplete
             else @list.tasks
             end

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace(
          "list_tasks_#{@list.id}",
          partial: "tasks/list",
          locals: { tasks: @tasks }
        )
      end
      format.html
    end
  end

  def new
    @list = List.new
    @list.tasks.build
  end

  def edit
    @list = List.find(params[:id])
    @list.tasks.build if @list.tasks.empty?

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("list_card_", partial: "lists/form", locals: { list: @list })
      end
      format.html
    end
  end

  def create
    @list = List.new(list_params)

    if @list.save
      respond_to_create_success
    else
      @lists = List.all
      @list.tasks.build if @list.tasks.empty?
      respond_to_create_failure
    end
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("list_card_#{@list.id}", partial: "lists/card",
                                                                             locals: { list: @list })
        end
        format.html { redirect_to @list, notice: t("lists.notices.updated") }
      end
    else
      @list.tasks.build if @list.tasks.empty?
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("list_card_#{@list.id}", partial: "lists/form",
                                                                             locals: { list: @list })
        end
        format.html { render :edit }
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    flash.now[:notice] = t("notices.destroyed") if @list.destroy
  end

  private

  def list_params
    params.expect(
      list: [:title,
             :description,
             { tasks_attributes: [:id, :title, :description, :priority, :_destroy] }]
    )
  end

  def respond_to_create_success
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.prepend("list_cards", partial: "lists/card", locals: { list: @list }),
          turbo_stream.replace("new_list_card", partial: "lists/new_card")
        ]
      end
      format.html { redirect_to lists_path, notice: t("lists.notices.created") }
    end
  end

  def respond_to_create_failure
    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: turbo_stream.replace("new_list_card", partial: "lists/form", locals: { list: @list })
      end
      format.html { render :index }
    end
  end
end
