class UserSerializer < ActiveModel::Serializer
  attributes :id, :email

  def attributes
    data = super
    data[:auth_token] = object.auth_token if serialization_options[:show_auth_token]
    data
  end
end
