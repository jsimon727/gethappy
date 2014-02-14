class User < ActiveRecord::Base
  has_many :favorites
  has_many :locations, through: :favorites 
  has_secure_password
end
