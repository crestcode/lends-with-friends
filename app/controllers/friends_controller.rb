class FriendsController < ApplicationController
  before_action :get_friend, except: [:index, :create]
  respond_to :html, :json

  def index
    @friends = Friend.all
    respond_with do |format|
      format.json { render json: @friends }
      format.html
    end
  end

  def create
    @friend = Friend.new(friend_params)
    if @friend.save
      render json: @friend, status: :ok
    else
      render json: {friend: @friend.errors}, status: :no_content
    end
  end

  def show
    respond_with(@friend)
  end

  def update
    if @friend.update_attributes(friend_params)
      render json: @friend, status: :ok
    else
      render json: {friend: @friend.errors}, status: :unprocessable_entity
    end
  end

  def destroy
    @friend.destroy
    render json: {}, status: :ok
  end

  private

  def friend_params
    unless params['friend']['loans'].blank?
      params['friend']['loans_attributes'] = params['friend']['loans']
      params['friend'].delete('loans')
    end
    params.fetch(:friend, {}).permit(:first_name, :last_name, :email, :phone,
                                     :loans_attributes => [:id, :item, :_destroy, :friend_id])
  end

  def get_friend
    @friend = Friend.find_by_id(params[:id])
    render json: {}, status: :not_found unless @friend
  end

  def default_serializer_options
    { root: false }
  end
end
