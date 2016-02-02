class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    
    alias_action :create, :read, :update, :destroy, :to => :crud

    if user.admin?
      can     :crud,  :all
    elsif user.manager?
      can     :crud,  User
    elsif user.user?
      can     :crud,  User, :id => user.id
      cannot  :index, User
    end
  end
end