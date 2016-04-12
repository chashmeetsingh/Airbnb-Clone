class ApiController < ApplicationController

  def favourite
    f = Favourite.find_by(cust_id: current_user.id, provider_id: params[:userID])
    if f
      Favourite.find_by(cust_id: current_user.id, provider_id: params[:userID]).delete
      render json: {
        response: 'unfavourite'
      }
    else
      Favourite.create(
        cust_id: current_user.id,
        provider_id: params[:userID]
      )
      render json: {
        response: 'favourite'
      }
    end
  end

  def all
    @favourites = Favourite.where(cust_id: current_user.id)
  end
end
