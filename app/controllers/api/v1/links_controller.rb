class Api::V1::LinksController < ApplicationController

  before_action :authenticate

  def index 

    case params[:tab]
    when "dashboard"
      dashboard_index 
    when "all_extras"
      all_extras_index 
    when "extra"
      extra_index 
    end

  end

  def create

    user_params = params.require(:session)

    @link = Link.new(link_create_params)
    @user = User.find_by(chatwoot_id: user_params[:chatwoot_id])

    @link[:user_id] = @user[:id]

    if @link.save 
      render json: @link, status: :ok
    else
      render json: @link.errors.full_messages, status: :bad_request
    end
    
  end

  def update
    @link = Link.find_by(id: params[:id])
    return not_found unless @link
  
    if @link.update(link_update_params)
      render json: @link, status: :ok
    else
      render json: @link.errors.full_messages, status: :bad_request
    end
  end

  def destroy

    user_params = params.require(:session)

    @link = Link.find_by(id: params[:id])
    @user = User.find_by(id: @link[:user_id])

    if user_params[:chatwoot_id] == @user[:chatwoot_id]
      @link.destroy
    end
  end

  private

  def link_create_params
    params.permit(:source, :rec_time, :time_moment_in_call, :reason, :description)
  end

  def link_update_params
    params.permit(:comment, :approved)
  end

  def index_params
    @index_params ||= params.permit(:user_id, :created_at_from, :created_at_to)
  end
  
  def index_scope
    Link.all
      .then { |scope| by_user_id(scope) }
      .then { |scope| by_created_at_to(scope) }
      .then { |scope| by_created_at_from(scope) }
  end
  
  def by_user_id(scope)
    return scope if index_params[:user_id].blank?
  
    scope.where(user_id: index_params[:user_id])
  end
  
  def by_created_at_to(scope)
    return scope if index_params[:created_at_to].blank?
  
    scope.where("links.created_at <= ?", Time.zone.parse(index_params[:created_at_to]))
  end
  
  def by_created_at_from(scope)
    return scope if index_params[:created_at_from].blank?
  
    scope.where("links.created_at >= ?", Time.zone.parse(index_params[:created_at_from]))
  end

  def dashboard_index

    @links_for_okk = index_scope.where(approved: 0)

    @result = {
      "counters" => {
        "waiting_for_approve" => @links_for_okk.size
      },
      "links" => @links_for_okk
    }

    render json: @result, status: :ok
  end

  def all_extras_index
    @full_list = index_scope

    @result = []

    @teams = Team.all 
    @teams.each do |team|
      @result << {
        "team_id" => team[:id],
        "team_name" => team[:name],
        "team_members" => count_team_members(team)
      }
    end

    render json: @result, status: :ok
  end

  def count_team_members(team)
    @users = User.all.where(team_id: team[:id])

    @user_result = []

    @users.each do |user|
      @user_result << {
        "user_id" => "#{user[:id]}",
        "user_name" => "#{user[:chatwoot_name]}",
        "counters" => {
          "waiting_for_approve" => "#{@full_list.where(approved: 0).where(user_id: user[:id]).size}",
          "approved" => "#{@full_list.where(approved: 1).where(user_id: user[:id]).size}",
          "not_approved" => "#{@full_list.where(approved: 2).where(user_id: user[:id]).size}",
          "all_count" => "#{@full_list.where(user_id: user[:id]).size}"
        }
      }
    end

    return @user_result
  end

  def extra_index 

    @full_list = index_scope

    sorting

    render json: @result, status: :ok
  end

  def sorting

    @links_list = []

    links_approved = []
    links_not_approved = []
    links_waiting_for_approve = []

    @full_list.each do |link|
      case link[:approved]
      when 1
        links_approved << link 
      when 2
        links_not_approved << link
      when 0
        links_waiting_for_approve << link
      end
    end

    @links_list = links_approved + links_not_approved + links_waiting_for_approve

    @result = {
      "counters" => {
          "waiting_for_approve" => "#{links_waiting_for_approve.size}",
          "approved" => "#{links_approved.size}",
          "not_approved" => "#{links_not_approved.size}",
          "all_count" => "#{@full_list.size}"
        },
      "links" => @links_list
    }
    
  end
  
end
