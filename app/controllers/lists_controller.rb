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
      redirect_to lists_path, notice: "List was successfully created."
    else
      @lists = List.all
      render :index
    end
  end

  private

  def list_params
    params.require(:list).permit(:title, :description)
  end
end
