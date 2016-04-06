class BookingController < ApplicationController
  before_action :authenticate_user!

  @@price
  @@start_date
  @@end_date
  @@provider

  def index
    @bookings = Booking.where(cust_id: current_user.id).order('created_at DESC')
  end

  def sitter
    @bookings = Booking.where(provider_id: current_user.id).order('created_at DESC')
  end

  def new
    @dogs = current_user.dogs
    if @dogs
      @provider = User.find(params[:booking][:provider_id]).id
      @start_date = params[:booking][:start_date]
      @end_date = params[:booking][:end_date]

      @no_of_days = (@end_date.to_date - @start_date.to_date).to_i + 1
      @per_day_price = User.find(@provider).per_day_price
      @total_price = @per_day_price * @no_of_days

      @@price = @total_price
      @@start_date = @start_date
      @@end_date = @end_date
      @@provider = @provider

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

      puts customer.id

      StripeCustomer.create(user_id: current_user.id, stripe_customer_id: customer.id)
    end

    stripe_customer = StripeCustomer.find_by(user_id: current_user.id)

    puts stripe_customer.stripe_customer_id

    @booking = Booking.create(
      start_date: @@start_date,
      end_date: @@end_date,
      description: params[:description],
      provider_id: @@provider,
      cust_id: current_user.id,
      stripeToken: token,
      stripe_customer_id: stripe_customer.stripe_customer_id,
      price: @@price * 100
    )

    if @booking.save
      flash[:success] = 'Booking Request successfully sent.'
    else
      flash[:error] = 'Error making a request'
    end

    redirect_to '/user/' + User.find(@@provider).username
  end

  def accept
    booking = Booking.find(params[:booking_id])

    Stripe::Charge.create(
                    amount: booking.price,
                    currency: 'usd',
                    customer: booking.stripe_customer_id
    )
    booking.update_attributes(paid: true, accept: true)

    flash[:success] = 'Booking Accepted'
    redirect_to booking_sitter_url
  end
end
