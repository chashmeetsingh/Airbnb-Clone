class HomeController < ApplicationController
  add_flash_types :error, :success
  before_action :authenticate_user!, only: [ :profile ]
  require 'haversine'

  def index
  end

  def sitter
    @users = User.all
  end

  def profile
  end

  def update_profile
    # @user = current_user
    # if params[:first_name] != nil && params[:last_name] != nil
    #   if params[:lat] != nil && params[:lng] != nil
    #     if params[:phone_no] != nil
    #
    #       redirect_to '/profile', success: 'Successfully updated!'
    #     else
    #       @user.update_attributes(first_name: params[:first_name], last_name: params[:last_name],
    #                                      address: params[:location], lat: params[:lat], lng: params[:lng])
    #       redirect_to '/profile', success: 'Successfully updated!'
    #     end
    #   end
    # end
    redirect_to profile_url, error: 'Error updating'
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
end
