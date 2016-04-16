class ProfileController < ApplicationController
  add_flash_types :error, :success
  before_action :authenticate_user!, only: [:profile]

  def profile
  end

  def update_profile
    if params[:user][:address].empty?
      if current_user.address.empty?
        flash[:error] = 'Please Specify a valid address'
      else
        update_user_without_address
      end
    elsif !params[:user][:address].empty?
      update_user_with_address
    elsif !params[:user][:phone_no].nil?
      update_user_without_address
    else
      update_user_with_address
    end
    redirect_to profile_url
  end

  def update_user_with_address
    if !params[:user][:lat].blank? && !params[:user][:lng].blank?
      begin
        current_user.update_without_password(user_params_with_address)
        flash[:success] = 'Successfully updated!'
      rescue => ex
        logger.error ex.message
        flash[:error] = 'Error Updating'
      end
    else
      flash[:success] = 'Successfully updated!'
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
