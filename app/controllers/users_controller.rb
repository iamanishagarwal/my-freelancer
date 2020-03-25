# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    if logged_in?
      flash[:danger] = 'User is already logged in'
      redirect_to root_path
    end
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User Successfully signed up'
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @user.update(user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = 'User successfully deleted'
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can only edit your own account'
      redirect_to root_path
    end
  end
end
