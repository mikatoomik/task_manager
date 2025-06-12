class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)
    if @list.save
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_list_card", partial: "lists/card", locals: { list: @list }) }
        format.html { redirect_to lists_path, notice: t("lists.notices.created") }
      end
    else
      @lists = List.all
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_list_card", partial: "lists/form", locals: { list: @list }) }
        format.html { render :index }
      end
    end
  end

  def show
    @list = List.includes(:tasks).find(params[:id])
    @tasks = @list.tasks
    if params[:status].present?
      @tasks = @tasks.public_send(params[:status]) if %w[incomplete completed].include?(params[:status])
    end
    if params[:priority].present?
      @tasks = @tasks.by_priority(params[:priority])
    end
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("list_card_", partial: "lists/show", locals: { list: @list }) }
      format.html
    end
  end

  def edit
    @list = List.find(params[:id])
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.replace("list_card_", partial: "lists/form", locals: { list: @list }) }
      format.html
    end
  end

  def update
    @list = List.find(params[:id])
    if @list.update(list_params)
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("list_card_#{@list.id}", partial: "lists/card", locals: { list: @list }) }
        format.html { redirect_to @list, notice: t("lists.notices.updated") }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("list_card_#{@list.id}", partial: "lists/form", locals: { list: @list }) }
        format.html { render :edit }
      end
    end
  end

  def destroy
    @list = List.find(params[:id])
    if @list.destroy
      redirect_to lists_path, notice: t("lists.notices.destroyed")
    else
      redirect_to @list, alert: @list.errors.full_messages.to_sentence
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end
end
