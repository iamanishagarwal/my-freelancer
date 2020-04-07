# frozen_string_literal: true

class FreelancersController < ApplicationController
  before_action :set_freelancer, only: %i[edit update show]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update]

  def index
    @freelancers = Freelancer.all
  end

  def new
    @freelancer = Freelancer.new
  end

  def create
    @freelancer = Freelancer.new(freelancer_params)
    @freelancer.user = current_user
    if @freelancer.save
      flash[:success] = 'Details were added successfully'
      redirect_to freelancer_path(@freelancer)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @freelancer.update(freelancer_params)
      flash[:success] = 'Details were updated successfully'
      redirect_to freelancer_path(@freelancer)
    else
      render 'edit'
    end
  end

  def show
    @user = @freelancer.user
  end

  private

  def set_freelancer
    @freelancer = Freelancer.find(params[:id])
  end

  def freelancer_params
    params.require(:freelancer).permit(:qualification, :experience, :industry, :avatar)
  end

  def require_same_user
    if current_user != @freelancer.user
      flash[:danger] = 'You can only edit your own details'
      redirect_to root_path
    end
  end
end
