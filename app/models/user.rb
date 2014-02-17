class User < ActiveRecord::Base
  has_many :favorites
  has_many :locations, through: :favorites 
  has_secure_password
  after_validation :geocode
  geocoded_by :ip_address

  def ip_address
    @client_ip = request.remote_ip
    return @client_ip # "68.173.59.192"
  end
end
