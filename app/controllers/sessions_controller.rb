# frozen_string_literal: true

class SessionsController < ApplicationController
  def new
    if logged_in?
      flash[:danger] = 'User is already logged in'
      redirect_to root_path
    end
  end

  def create
    @user = User.find_by(email: params[:session][:email].downcase)
    if @user&.authenticate(params[:session][:password])
      if @user.email_confirmed
        session[:user_id] = @user.id
        flash[:success] = 'Logged in successfully'
        redirect_to user_path(@user)
      else
        flash.now[:danger] = 'Please activate your account by following the
        instructions in the account confirmation email you received to proceed'
        render 'new'
      end
    else
      flash.now[:danger] = 'There was something wrong with the login information'
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'You have successfully logged out'
    redirect_to root_path
  end
end
