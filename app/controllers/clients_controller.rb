# frozen_string_literal: true

class ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update show]
  before_action :require_user, except: %i[index show]
  before_action :require_same_user, only: %i[edit update]

  def index
    @clients = Client.all
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    @client.user = current_user
    if @client.save
      flash[:success] = 'Details were added successfully'
      redirect_to client_path(@client)
    else
      render 'new'
    end
  end

  def edit; end

  def update
    if @client.update(client_params)
      flash[:success] = 'Details were updated successfully'
      redirect_to client_path(@client)
    else
      render 'edit'
    end
  end

  def show; end

  private

  def set_client
    @client = Client.find(params[:id])
  end

  def client_params
    params.require(:client).permit(:industry, :avatar)
  end

  def require_same_user
    if current_user != @client.user
      flash[:danger] = 'You can only edit your own details'
      redirect_to root_path
    end
  end
end
