class AccessorizationPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'accessorization:index'
  end

  def show?
    user_activities.include? 'accessorization:show'
  end

  def new?
    create?
  end

  def create?
    user_activities.include? 'accessorization:create'
  end

  def edit?
    update?
  end

  def update?
    user_activities.include? 'accessorization:update'
  end

  def destroy?
    user_activities.include? 'accessorization:delete'
  end
 

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end