class ErrandPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'errand:index'
  end

  def show?
    user_activities.include? 'errand:show'
  end

  def new?
    create?
  end

  def create?
    user_activities.include? 'errand:create'
  end

  def edit?
    update?
  end

  def update?
    user_activities.include? 'errand:update'
  end

  def destroy?
    user_activities.include? 'errand:delete'
  end

  def work?
    user_activities.include? 'errand:work'
  end

 
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end