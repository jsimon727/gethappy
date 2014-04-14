class Bar < ActiveRecord::Base
  belongs_to :location
  has_many :users, through: :favorite_bars
end