class Booking < ActiveRecord::Base
  # belongs_to :user, foreign_key: :cust_id
  belongs_to :customer, class_name: 'User', foreign_key: 'cust_id'
  belongs_to :provider, class_name: 'User', foreign_key: 'provider_id'
end
