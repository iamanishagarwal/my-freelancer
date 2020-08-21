# frozen_string_literal: true

class ProposalsController < ApplicationController
  before_action :require_user_freelancer

  def create
    @proposal = Proposal.new(proposal_params)
    if @proposal.save
      flash[:success] = 'You have successfully applied for job'
      redirect_to job_path(@proposal.job_id)
    else
      flash[:danger] = 'Something went wrong. Failed to apply for job'
      redirect_to jobs_path
    end
  end

  def destroy
    @proposal = Proposal.find(params[:id])
    if @proposal.freelancer != current_user.freelancer
      flash[:danger] = 'You can only edit your own details'
      redirect_to root_path
    end
    @proposal.destroy
    flash[:now] = 'Proposal successfully withdrawn'
    redirect_to jobs_path
  end

  private

  def proposal_params
    params.permit(%i[freelancer_id job_id])
  end

  def require_user_freelancer
    require_user
    unless current_user.role? 'freelancer'
      redirect_to root_path
      flash[:danger] = 'You must be a freelancer for performing this action'
    end
  end
end
