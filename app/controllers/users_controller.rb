class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  # List all users
  def index
    users = User.all
    render json: users
  end

  # Show a specific user
  def show
    render json: @user
  end

  # Create a new user
  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created, location: user
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update an existing user
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # Delete a user
  def destroy
    @user.destroy
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
