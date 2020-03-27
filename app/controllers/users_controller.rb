# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  # before_action :require_same_user, only: %i[edit update destroy]

  def index
    @users = User.all
  end

  def new
    if logged_in?
      flash[:danger] = 'User is already logged in'
      redirect_to root_path
    end
    @user = User.new
    authorize! :new, @user
  end

  def create
    @user = User.new(create_user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User Successfully signed up'
      redirect_to user_path(@user)
    else
      render 'new'
    end
    authorize! :create, @user
  end

  def edit
    authorize! :edit, @user
  end

  def update
    if @user.update(update_user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
    authorize! :update, @user
  end

  def show; end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:danger] = 'User successfully deleted'
    redirect_to root_path
    authorize! :destroy, @user
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def create_user_params
    params.require(:user).permit(:name, :email, :password, :role)
  end

  def update_user_params
    params.require(:user).permit(:name, :email)
  end

  # def require_same_user
  #   if current_user != @user
  #     flash[:danger] = 'You can only edit your own account'
  #     redirect_to root_path
  #   end
  # end
end
