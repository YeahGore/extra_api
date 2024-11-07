class Api::V1::UsersController < ApplicationController

  before_action :authenticate

  def index
    @users = User.all 
    @users = sorting if @users != nil

    render json: @users, status: :ok
  end

  def create 
    @user = User.new(user_create_params)

    if @user.save 
      render json: @user, status: :ok
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    return not_found unless @user
  
    if @user.update(user_update_params)
      render json: @user, status: :ok
    else
      render json: @user.errors.full_messages, status: :bad_request
    end
  end

  def list_of_roles
    render json: User.roles.keys, status: :ok
  end

  private

  def user_create_params
    params.permit(:role, :chatwoot_name, :chatwoot_id)
  end

  def user_update_params
    params.permit(:role, :chatwoot_name, :team_id)
  end

  def sorting    

    result = @users.sort {|a,b| a[:chatwoot_name] <=> b[:chatwoot_name]}
    return result
    
  end
 
end
