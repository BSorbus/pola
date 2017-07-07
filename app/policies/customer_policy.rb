class CustomerPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'customer:index'
  end

  def show?
    user_activities.include? 'customer:show'
  end
 
  def new?
    create?
  end

  def create?
    user_activities.include? 'customer:create'
  end

  def edit?
    update?
  end

  def update?
    user_activities.include? 'customer:update'
  end

  def destroy?
    user_activities.include? 'customer:delete'
  end
 
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end