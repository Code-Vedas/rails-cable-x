class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    render json: { users: User.all }
  end

  def show
    render json: { user: @user}
  end

  def update
    @user.update(update_user_params)
    render json: { user: @user }
  end

  def destroy
    @user.destroy
    render json: { user: @user }
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      render json: { user: @user }, status: 201
    else
      render json: { error: @user.errors.full_messages.join(',') }
    end
  end

  private

  def create_user_params
    params.require(:user).permit(:first_name, :last_name, :email)
  end

  def update_user_params
    params.require(:user).permit(:first_name, :last_name)
  end

  def set_user
    @user = User.find(params[:id]) rescue nil
    render json: { error: "User with id #{params[:id]} not found!" }, status: 404 unless @user
  end
end
