class FriendsController < ApplicationController
  before_action :get_friend, except: [:index, :create]
  respond_to :html, :json

  def index
    @friends = Friend.all
    respond_with do |format|
      format.json { render json: @friends.as_json }
      format.html
    end
  end

  def create
    @friend = Friend.new(friend_params)
    if @friend.save
      render json: @friend.as_json, status: :ok
    else
      render json: {friend: @friend.errors}, status: :no_content
    end
  end

  def show
    respond_with(@friend.as_json)
  end

  def update
    if @friend.update_attributes(friend_params)
      render json: @friend.as_json, status: :ok
    else
      render json: {friend: @friend.errors}, status: :unprocessable_entity
    end
  end

  private

  def friend_params
    params.fetch(:friend, {}).permit(:first_name, :last_name, :email, :phone)
  end

  def get_friend
    @friend = Friend.find_by_id(params[:id])
    render json: {}, status: :not_found unless @friend
  end
end
