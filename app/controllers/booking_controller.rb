class BookingController < ApplicationController

  def index
    @bookings = Booking.where(cust_id: current_user.id).order('created_at DESC')
  end

  def new
    @dogs = current_user.dogs
    if @dogs
      @provider = User.find(params[:booking][:provider_id]).id
      @start_date = params[:booking][:start_date]
      @end_date = params[:booking][:end_date]
    else
      redirect_to dog_index_path, notice: 'Please add a dog'
    end
  end

  def create
    Stripe.api_key = ENV['API_KEY']
    token = params[:stripeToken]

    stripe_customer = StripeCustomer.find_by(user_id: current_user.id)

    if stripe_customer.nil?
      # Create a Customer
      customer = Stripe::Customer.create(
          :source => token,
          :description => "Airbnb Clone [#{current_user.id}] [#{current_user.username}]",
          :email => current_user.email
      )

      StripeCustomer.create(user_id: current_user.id, stripe_user_id: customer.id)
    end

    stripe_customer = StripeCustomer.find_by(user_id: current_user.id)

    # Charge the Customer instead of the card
    Stripe::Charge.create(
        :amount => params[:totalAmount].to_i, # in cents
        :currency => 'usd',
        :customer => stripe_customer.stripe_user_id
    )

    @booking = Booking.create(
                  start_date: Date.new(params[:start_date].to_i),
                  end_date: Date.new(params[:end_date].to_i),
                  description: params[:description],
                  provider_id: params[:provider_id],
                  cust_id: current_user.id,
                  stripeToken: token,
                  stripe_customer_id: stripe_customer.id
    )

    if @booking.save
      flash[:success] = 'Booking Request successfully sent.'
    else
      flash[:error] = 'Error making a request'
    end

    redirect_to '/user/' + User.find(params[:provider_id]).username
  end
end
