require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    dogs: Field::HasMany,
    messages: Field::HasMany,
    my_bookings: Field::HasMany.with_options(class_name: "Booking"),
    requested_bookings: Field::HasMany.with_options(class_name: "Booking"),
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    sign_in_count: Field::Number,
    current_sign_in_at: Field::DateTime,
    last_sign_in_at: Field::DateTime,
    current_sign_in_ip: Field::String,
    last_sign_in_ip: Field::String,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    username: Field::String,
    first_name: Field::String,
    last_name: Field::String,
    country: Field::String,
    address: Field::String,
    city: Field::String,
    state: Field::String,
    phone_no: Field::Number,
    profile_image: Field::String,
    lat: Field::Number.with_options(decimals: 2),
    lng: Field::Number.with_options(decimals: 2),
    per_day_price: Field::Number,
    role: Field::String.with_options(searchable: false),
  }

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = [
    :id,
    :username,
    :first_name,
    :last_name,
    :dogs,
    :messages,
    :my_bookings,
    :requested_bookings,
  ]

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = [
    :id,
    :username,
    :first_name,
    :last_name,
    :email,
    :address,
    :city,
    :state,
    :country,
    :phone_no,
    :profile_image,
    :lat,
    :lng,
    :per_day_price,
    :role,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :created_at,
    :updated_at,
    :dogs,
    :my_bookings,
    :requested_bookings,
    :messages,
  ]

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = [
    :username,
    :first_name,
    :last_name,
    :email,
    :address,
    :city,
    :state,
    :country,
    :phone_no,
    :profile_image,
    :lat,
    :lng,
    :per_day_price,
    :role,
    :encrypted_password,
    :reset_password_token,
    :reset_password_sent_at,
    :remember_created_at,
    :sign_in_count,
    :current_sign_in_at,
    :last_sign_in_at,
    :current_sign_in_ip,
    :last_sign_in_ip,
    :dogs,
    :messages,
    :my_bookings,
    :requested_bookings,
  ]

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end
