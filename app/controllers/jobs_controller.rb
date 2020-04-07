# frozen_string_literal: true

class JobsController < ApplicationController
  before_action :set_job, only: %i[edit update show destroy]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update destroy]

  def index
    @jobs = Job.all
  end

  def new
    @job = Job.new
  end

  def create
    @job = Job.new(job_params)
    @job.user = current_user
    if @job.save
      flash[:success] = 'Job was created successfully'
      redirect_to job_path(@job)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @job.update(job_params)
      flash[:success] = 'Job was updated successfully'
      redirect_to job_path(@job)
    else
      render 'edit'
    end
  end

  def show; end

  def destroy
    @job.destroy
    flash[:danger] = 'Job was deleted successfully'
    redirect_to root_path
  end

  private

  def set_job
    @job = Job.find(params[:id])
  end

  def job_params
    params.require(:job).permit(:title, :description, :document)
  end

  def require_same_user
    if current_user != @job.user
      flash[:danger] = 'You can only edit your own details'
      redirect_to root_path
    end
  end
end
