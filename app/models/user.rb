class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :dogs
  has_many :pets
  has_many :messages
  # has_many :bookings, foreign_key: 'cust_id'
  has_many :my_bookings,        class_name: 'Booking', foreign_key: 'cust_id'
  has_many :requested_bookings, class_name: 'Booking', foreign_key: 'provider_id'

  enum role: [:sitter, :customer]
  after_initialize :set_default_role, :if => :new_record?

  def set_default_role
    self.role ||= :customer
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  validates_presence_of :username
  validates_uniqueness_of :username

  # This could replace has_many :bookings
  # def bookings
  #  Booking.where("cust_id = ? OR provider_id = ?", self.id, self.id)
  # end
end
