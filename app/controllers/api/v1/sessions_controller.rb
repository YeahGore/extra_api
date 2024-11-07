class Api::V1::SessionsController < ApplicationController

  before_action :authenticate

  def create
    # user_params = params.require(:session)

    @user = User.find_by(chatwoot_id: params[:chatwoot_id])

    if @user.present?
      session[:chatwoot_id] = @user[:chatwoot_id]
      session[:role] = @user[:role]
    else
      @user = User.create(role: 1, chatwoot_name: params[:user_name], chatwoot_id: params[:user_id]) if params[:user_id] == "4"
      @user = User.create(role: 0, chatwoot_name: params[:user_name], chatwoot_id: params[:user_id]) if params[:user_id] != "4"

      session[:chatwoot_id] = @user[:chatwoot_id]
      session[:role] = @user[:role]
    end

    # @user = User.create(role: "admin", chatwoot_name: params[:user_name], chatwoot_id: params[:user_id]) if params[:user_id] == "4"
    # @user = User.create(role: "support", chatwoot_name: params[:user_name], chatwoot_id: params[:user_id]) if params[:user_id] != "4"
    # render json: @user, status: :ok
  end

 end
