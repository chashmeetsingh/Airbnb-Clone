class RatingSitter < ActiveRecord::Base
  validates_uniqueness_of :booking_id
end
