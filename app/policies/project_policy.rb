class ProjectPolicy < ApplicationPolicy
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
                        project: [@model] 
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
      @model.accesses_roles
        .where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]]}, 
               accessorizations: {user_id: [@user]})
        .select(:activities).distinct.map(&:activities).flatten
    end
    # wybierz activites for user accessorizations from events ex.;
    # ["*:index", "*:show", "*:create", "*:update", "*:delete", "*:project_index", "*:project_show", "*:project_create", "*:project_delete"]
  end

  def index?
    (user_activities.include? 'project:index') || (event_activities(@model).include? 'project:index')
  end

  def show?
    (user_activities.include? 'project:show') || (event_activities(@model).include? 'project:show')
  end
 
  def new?
    create?
  end

  def create?
    (user_activities.include? 'project:create') || (event_activities(@model).include? 'project:create')
  end

  def edit?
    update?
  end

  def update?
    (user_activities.include? 'project:update') || (event_activities(@model).include? 'project:update')
  end

  def destroy?
    (user_activities.include? 'project:delete') || (event_activities(@model).include? 'project:delete')
  end
 
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end
end