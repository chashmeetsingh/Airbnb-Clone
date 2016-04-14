class HomeController < ApplicationController
  add_flash_types :error, :success
  before_action :authenticate_user!, only: [ :profile, :sitter ]
  require 'haversine'

  def index
  end

  def sitter
    @users = User.where(role: 0).limit(10)
  end

  def profile
  end

  def update_profile
    if params[:user][:address].nil?
      if current_user.address.empty?
        flash[:error] = 'Please Specify a valid address'
      else
        update_user_without_address
      end
    else
      update_user_with_address
    end
    redirect_to profile_url
  end

  def update_user_with_address
    begin
      current_user.update_without_password(user_params_with_address)
      flash[:success] = 'Successfully updated!'
    rescue => ex
      logger.error ex.message
      flash[:error] = 'Error Updating'
    end
  end

  def update_user_without_address
    begin
      current_user.update_without_password(user_params_without_address)
      flash[:success] = 'Successfully updated!'
    rescue => ex
      logger.error ex.message
      flash[:error] = 'Error Updating'
    end
  end

  def search
    @lng = params[:lng].to_f
    @lat = params[:lat].to_f
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @location_query = params[:autocomplete]

    query = [ @lat, @lng ]

    @users = Array.new
    # @users = User.all

    User.where(role: 0).each do |user|

      if user_signed_in?
        if user == current_user
          next
        end
      end

      boolBook = true

      unless @start_date.empty? && @end_date.empty?
        Booking.where(provider_id: user.id).each do |booking|
          if @start_date.to_date <= booking.end_date && @end_date.to_date >= booking.start_date
            boolBook = false
          end
          break if boolBook == false
        end
      end

      if boolBook == true
        unless user.lat.nil? && user.lng.nil?
          user_coor = [ user.lat, user.lng ]

          if Haversine.distance(query, user_coor).to_km < 20
            @users << user
          end
        end
      end
    end

    @users = @users[0..20]
  end

  def search_api
    lng = params[:lng].to_f
    lat = params[:lat].to_f
    start_date = params[:start_date]
    end_date = params[:end_date]
    location_query = params[:autocomplete]

    query = [ lat, lng ]

    users = Array.new
    # @users = User.all

    User.where(role: 0).each do |user|

      if user_signed_in?
        if user == current_user
          next
        end
      end

      boolBook = true

      unless start_date.empty? && end_date.empty?
        Booking.where(provider_id: user.id).each do |booking|
          if start_date.to_date <= booking.end_date && end_date.to_date >= booking.start_date
            boolBook = false
          end
          break if boolBook == false
        end
      end

      if boolBook == true
        unless user.lat.nil? && user.lng.nil?
          user_coor = [ user.lat, user.lng ]

          if Haversine.distance(query, user_coor).to_km < 20
            users << user
          end
        end
      end
    end

    userArray = Array.new

    users[0..20].each do |user|
      fav = false
      if user_signed_in?
        if Favourite.find_by(cust_id: current_user.id, provider_id: user.id)
          fav = true
        end
      end
      userArray << {
        username: user.username,
        first_name: user.first_name,
        last_name: user.last_name,
        lat: user.lat,
        lng: user.lng
      }
    end

    render json: {
      users: userArray
    }
  end

  def public_profile
    @user = User.find_by(username: params[:username])
    @bookings = Booking.where(provider_id: @user.id, paid: true)
    @ratings = RatingSitter.where(provider_id: @user.id)
  end

  private

  def user_params_with_address
    params[:user].permit(:first_name, :last_name, :phone_no, :address, :lat, :lng, :per_day_price)
  end

  def user_params_without_address
    params[:user].permit(:first_name, :last_name, :phone_no, :per_day_price)
  end
end
