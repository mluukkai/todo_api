class TodoItemsController < ApplicationController
  before_action :set_todo_item, only: [:destroy, :update]
  before_action :set_user
  before_action :authorize, only: [:destroy, :update]

  def index
    @todo_items = @user.todo_items
  end

  def create
    @todo_item = TodoItem.new(todo_item_params)
    @todo_item.done = false
    @todo_item.user = @user

    if @todo_item.save
      render :show, status: :created, location: @todo_item 
    else
      render json: @todo_item.errors, status: :unprocessable_entity 
    end
  end

  def update
    @todo_item.done = true

    if @todo_item.save
      render :show, status: :ok, location: @todo_item 
    else
      render json: @todo_item.errors, status: :unprocessable_entity 
    end
  end

  def destroy
    @todo_item.destroy
    head :no_content 
  end

  private
    def set_user
      token = request.headers['HTTP_AUTHORIZATION'] || ''
      @user = User.find_by token: token
      render json: { error: "Unauthorized" }, status: :unauthorized unless @user
    end

    def set_todo_item
      @todo_item = TodoItem.find(params[:id])
    end

    def todo_item_params
      params.require(:todo_item).permit(:name, :description, :done, :estimate, :user_id)
    end

    def authorize
      render json: { error: "Unauthorized" } unless @todo_item.user == @user
    end
end
