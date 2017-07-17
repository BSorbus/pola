class AttachmentPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  # Attachments for showed project 
  def project_index?
    # user_activities.include? 'attachment:index'
    user_activities.include? 'attachment:4project_index'
  end

  def project_show?
    # user_activities.include? 'attachment:show'
    user_activities.include? 'attachment:4project_show'
  end
 
  def project_create?
    # user_activities.include? 'attachment:create'
    user_activities.include? 'attachment:4project_create'
  end

  def project_destroy?
    # user_activities.include? 'attachment:delete'
    user_activities.include? 'attachment:4project_delete'
  end
 

  # Attachments for showed user 
  def user_index?
    # user_activities.include? 'attachment:index'
    user_activities.include? 'attachment:4user_index'
  end

  def user_show?
    # user_activities.include? 'attachment:show'
    user_activities.include? 'attachment:4user_show'
  end
 
  def user_create?
    # user_activities.include? 'attachment:create'
    user_activities.include? 'attachment:4user_create'
  end

  def user_destroy?
    # user_activities.include? 'attachment:delete'
    user_activities.include? 'attachment:4user_delete'
  end
 

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end