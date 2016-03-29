class Booking < ActiveRecord::Base
  belongs_to :user, foreign_key: :cust_id
end
