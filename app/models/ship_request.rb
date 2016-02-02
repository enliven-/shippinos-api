class ShipRequest < ActiveRecord::Base
  belongs_to :from_city,  class_name: City
  belongs_to :to_city,    class_name: City
  belongs_to :user
end
