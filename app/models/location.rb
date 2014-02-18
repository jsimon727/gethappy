class Location < ActiveRecord::Base
  has_many :favorites
  has_many :users, through: :favorites 
  has_many :bars
  has_many :deals
  validates :name, presence: true
  validates :zip_code, presence: true
end