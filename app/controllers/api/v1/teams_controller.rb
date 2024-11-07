class Api::V1::TeamsController < ApplicationController

  before_action :authenticate

  def create
    @team = Team.new(team_params)

    if @team.save 
      render json: @team, status: :ok
    else
      render json: @team.errors.full_messages, status: :bad_request
    end
  end

  def index
    @teams = Team.all 
    render json: @teams, status: :ok
  end

  def update
    @team = Team.find_by(id: params[:id])
    return not_found unless @team
  
    if @team.update(team_params)
      render json: @team, status: :ok
    else
      render json: @team.errors.full_messages, status: :bad_request
    end
  end

  def destroy
    @team = Team.find_by(id: params[:id])
    @team.destroy
  end

  private

  def team_params
    params.permit(:name, :team_type)
  end

end
