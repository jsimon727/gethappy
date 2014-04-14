class User < ActiveRecord::Base
  has_many :favorites
  has_many :locations, through: :favorites
  has_many :bars, through: :favorite_bars
  has_many :favorite_bars
  has_secure_password
  validates :email, presence: true, uniqueness: true
  validates :firstname, presence: true
  geocoded_by :ip_address, :latitude => :latitude, :longitude => :longitude
  after_validation :geocode
  end


