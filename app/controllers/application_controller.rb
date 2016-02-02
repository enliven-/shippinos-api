class ApplicationController < ActionController::API
  include Authenticable
  include ActionController::Serialization
  include CanCan::ControllerAdditions


  rescue_from CanCan::AccessDenied do |exception|
    render json: { errors: 'Not Authorized' }, status: :forbidden
  end
end
