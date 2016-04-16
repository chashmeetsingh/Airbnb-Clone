require "administrate/base_dashboard"

class BookingDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    customer: Field::BelongsTo.with_options(class_name: "User"),
    provider: Field::BelongsTo.with_options(class_name: "User"),
    id: Field::Number,
    cust_id: Field::Number,
    provider_id: Field::Number,
    start_date: Field::DateTime,
    end_date: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    description: Field::String,
    stripeToken: Field::String,
    stripe_customer_id: Field::String,
    price: Field::Number,
    paid: Field::Boolean,
    accept: Field::Boolean,
    complete: Field::Boolean,
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :customer,
    :provider,
    :start_date,
    :end_date,
    :price,
    :paid,
    :accept,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :customer,
    :provider,
    :id,
    :cust_id,
    :provider_id,
    :start_date,
    :end_date,
    :created_at,
    :updated_at,
    :description,
    :stripeToken,
    :stripe_customer_id,
    :price,
    :paid,
    :accept,
    :complete,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :customer,
    :provider,
    :cust_id,
    :provider_id,
    :start_date,
    :end_date,
    :description,
    :stripeToken,
    :stripe_customer_id,
    :price,
    :paid,
    :accept,
    :complete,
  ]

  # Overwrite this method to customize how bookings are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(booking)
  #   "Booking ##{booking.id}"
  # end
end
