class AccessorizationPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'accessorization:index'
  end

  def create_update_delete?
    user_activities.include? 'accessorization:create_update_delete'
  end

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end