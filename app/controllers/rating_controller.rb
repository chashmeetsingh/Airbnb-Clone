class RatingController < ApplicationController

  def sitter
    booking = Booking.find(params[:booking_id])
    if current_user
      if booking.complete
        rate = RatingSitter.create(
                      comment: params[:comment],
                      provider_id: booking.provider_id,
                      cust_id: current_user.id,
                      booking_id: booking.id,
                      rating: params[:rating]
        )
        if rate.save
          flash[:success] = 'Successfully Rated'
        else
          flash[:danger] = 'Error Performing Action'
        end
      else
        flash[:info] = 'Order not complete'
      end
    else
      flash[:warning] = 'Not enough rights to perform this action'
    end
    redirect_to '/booking/' + booking.id.to_s
  end
end
