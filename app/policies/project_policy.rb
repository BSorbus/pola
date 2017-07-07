class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def index?
    user_activities.include? 'project:index'
  end

  def show?
    user_activities.include? 'project:show'
  end
 
  def new?
    create?
  end

  def create?
    user_activities.include? 'project:create'
  end

  def edit?
    update?
  end

  def update?
    user_activities.include? 'project:update'
  end

  def destroy?
    user_activities.include? 'project:delete'
  end
 
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end