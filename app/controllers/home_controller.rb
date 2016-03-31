class HomeController < ApplicationController
  add_flash_types :error, :success
  before_action :authenticate_user!, only: [ :profile ]
  require 'haversine'

  def index
  end

  def sitter
    @users = User.all.limit(10)
  end

  def profile
  end

  def update_profile
    begin
      current_user.update_without_password(user_params)
      flash[:success] = 'Successfully updated!'
    rescue => ex
      logger.error ex.message
      flash[:error] = 'Error Updating'
    end
    redirect_to profile_url
  end

  def search
    @lng = params[:lng].to_f
    @lat = params[:lat].to_f

    query = [ @lat, @lng ]

    @users = Array.new
    # @users = User.all

    User.all.each do |user|

      if user_signed_in?
        if user == current_user
          next
        end
      end

      unless user.lat.nil? && user.lng.nil?
        user_coor = [ user.lat, user.lng ]

        if Haversine.distance(query, user_coor).to_km < 20
          @users << user
        end
      end
    end

    @users = @users[0..20]
  end

  def public_profile
    @user = User.find_by(username: params[:username])
  end

  private

  def user_params
    params[:user].permit(:first_name, :last_name, :phone_no, :address, :lat, :lng, :per_day_price)
  end
end
