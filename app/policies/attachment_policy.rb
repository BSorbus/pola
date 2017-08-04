class AttachmentPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

  def event_type_activities
    if @model.class.to_s == 'Symbol'
      EventType.joins(events: {accessorizations: [:user]})
        .references(:event, :accessorization, :user)
        .where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]], 
                        accessorizations: {user_id: [@user]}
                        })
        .select(:activities).distinct.map(&:activities).flatten
    else
      EventType.joins(events: {accessorizations: [:user], project: []})
        .references(:event, :accessorization, :user, :project)
        .where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]], 
                        accessorizations: {user_id: [@user]},
                        project: [@model.attachmenable] 
                        })
        .select(:activities).distinct.map(&:activities).flatten
    end      
    # wybierz activites z events np.;
    # ["project:*", "opinion:*" ]
  end

  def event_user_activities
    if @model.class.to_s == 'Symbol'
      []
    else
      # @model.accesses_roles
      @model.attachmenable.accesses_roles
        .where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]]}, 
               accessorizations: {user_id: [@user]})
        .select(:activities).distinct.map(&:activities).flatten
    end
    # wybierz activites for user accessorizations from events ex.;
    # ["*:index", "*:show", "*:create", "*:update", "*:delete", "*:project_index", "*:project_show", "*:project_create", "*:project_delete"]
  end

  # Attachments for showed project 
  def project_index?
    # user_activities.include? 'attachment:index'
    # user_activities.include? 'attachment:project_index'
    (user_activities.include? 'attachment:project_index') || (event_activities(@model).include? 'attachment:project_index')
  end

  def project_show?
    # user_activities.include? 'attachment:show'
    # user_activities.include? 'attachment:project_show'
    (user_activities.include? 'attachment:project_show') || (event_activities(@model).include? 'attachment:project_show')
  end
 
  def project_create?
    # user_activities.include? 'attachment:create'
    # user_activities.include? 'attachment:project_create'
    (user_activities.include? 'attachment:project_create') || (event_activities(@model).include? 'attachment:project_create')
  end

  def project_destroy?
    # user_activities.include? 'attachment:delete'
    # user_activities.include? 'attachment:project_delete'
    (user_activities.include? 'attachment:project_delete') || (event_activities(@model).include? 'attachment:project_delete')
  end
 

  # Attachments for showed user 
  def user_index?
    # user_activities.include? 'attachment:index'
    user_activities.include? 'attachment:user_index'
  end

  def user_show?
    # user_activities.include? 'attachment:show'
    user_activities.include? 'attachment:user_show'
  end
 
  def user_create?
    # user_activities.include? 'attachment:create'
    user_activities.include? 'attachment:user_create'
  end

  def user_destroy?
    # user_activities.include? 'attachment:delete'
    user_activities.include? 'attachment:user_delete'
  end
 

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end