class ShipRequestSerializer < ActiveModel::Serializer
  attributes :id, :from_city, :to_city, :from_date, :to_date, :size, :reward, :message
end
