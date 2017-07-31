class ProjectPolicy < ApplicationPolicy
  attr_reader :user, :model

  def initialize(user, model)
    @user = user
    @model = model
  end

# p.eventses_roles.where(accessorizations: {user_id: [4]})
# p.eventses_roles.where(events: {status: [Event.statuses[:opened], Event.statuses[:verification], Event.statuses[:closed] ]})

# p.eventses_roles.where(events: {status: [Event.statuses[:opened], Event.statuses[:verification], Event.statuses[:closed] ]}, 
#                        accessorizations: {user_id: [4]})


# p.eventses_roles.where(events: {status: [Event.statuses[:opened], Event.statuses[:verification], Event.statuses[:closed] ]}, 
#                        accessorizations: {user_id: [7]}).select(:activities)


  def event_type_activities
    EventType.joins(:events, events: [:accessorizations], events: {accessorizations: [:user]}).
      references(:event, :accessorization, :user).
      where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]]}, accessorizations: {user_id: [@user]}).
      select(:activities).distinct.map(&:activities).flatten 

    # wybierz activites z events np.;
    # ["project:*", "opinion:*" ]
  end

  def user_for_event_activities
    @model.eventses_roles.where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]]}, 
                      accessorizations: {user_id: [@user]}).select(:activities).distinct.map(&:activities).flatten

    # wybierz activites for user accessorizations from events ex.;
    # ["*:index", "*:show", "*:create", "*:update", "*:delete", "*:4project_index", "*:4project_show", "*:4project_create", "*:4project_delete"]
  end

  def event_activities
    a = event_type_activities
    b = user_for_event_activities

    ab = []
    a.each do |str_a|
      if str_a.include? ':*'
        b.each do |str_b|
          if str_b.include? '*:'
            ab << "#{str_a.gsub(':*', '' )}:#{str_b.gsub('*:', '' )}" 
          else
            ab << str_b
          end
        end
      else
        ab << str_a
      end
    end
    return ab
  end


  def index?
    user_activities.include? 'project:index'
  end


  def show_through_accesssorizations?
    event_activities.include? 'project:show'
  end

  def show?
    res = user_activities.include? 'project:show'
    res = show_through_accesssorizations? unless res
    res
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