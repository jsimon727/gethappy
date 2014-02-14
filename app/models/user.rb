class User < ActiveRecord::Base
  has_many :favorites
  has_many :locations, through: :favorites 
  has_secure_password
  after_validation :geocode
  geocoded_by :ip_address
end
