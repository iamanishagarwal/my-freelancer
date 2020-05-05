# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
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
    @user = User.new(create_user_params)
    if @user.save
      # session[:user_id] = @user.id
      # flash[:success] = 'User Successfully signed up'
      UserMailer.registration_confirmation(@user).deliver
      flash[:success] = 'Please confirm your email address to continue'
      # redirect_to user_path(@user)
      redirect_to root_path
    else
      render 'new'
    end
  end

  def confirm_email
    @user = User.find_by_confirm_token(params[:id])
    if @user
      @user.email_activate
      flash[:success] = 'Welcome to the My-Freelancer App! Your email has been confirmed.
      Please sign in to continue.'
      redirect_to login_url
    else
      flash[:danger] = 'Sorry. User does not exist'
      redirect_to root_url
    end
  end

  def edit; end

  def update
    if @user.update(update_user_params)
      flash[:success] = 'Your account was updated successfully'
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @user.destroy
    session[:user_id] = nil
    flash[:danger] = 'User successfully deleted'
    redirect_to root_path
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

  def require_same_user
    if current_user != @user
      flash[:danger] = 'You can only edit your own account'
      redirect_to root_path
    end
  end
end
