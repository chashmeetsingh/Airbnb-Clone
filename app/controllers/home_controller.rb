class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:sitter]

  require 'haversine'

  def index
  end

  def sitter
    @users = User.where(role: 0).limit(10)
  end

  def search
    @lng = params[:lng].to_f
    @lat = params[:lat].to_f
    @start_date = params[:start_date]
    @end_date = params[:end_date]
    @location_query = params[:autocomplete]

    query = [@lat, @lng]

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
          user_coor = [user.lat, user.lng]

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

    query = [lat, lng]

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
          user_coor = [user.lat, user.lng]

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
end
