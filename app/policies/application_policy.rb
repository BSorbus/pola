class ApplicationPolicy
  attr_reader :user, :record

  def initialize(user, record)
    #raise Pundit::NotAuthorizedError, "must be logged in" unless user
    @user = user
    @record = record
  end


  def event_type_activities
    EventType.joins(events: {accessorizations: [:user]})
      .references(:event, :accessorization, :user)
      .where(events: {status: [Event.statuses[:opened], Event.statuses[:verification]]}, 
            accessorizations: {user_id: [@user]})
      .select(:activities).distinct.map(&:activities).flatten 

    # wybierz activites z events np.;
    # ["project:*", "opinion:*" ]
  end

  def user_activities
    @user.roles.select(:activities).distinct.map(&:activities).flatten
  end

  def inferred_activity(method)
    "#{@record.class.name.downcase}:#{method.to_s}"
  end

  def method_missing(name,*args)
    if name.to_s.last == '?'
      user_activities.include?(inferred_activity(name.to_s.gsub('?','')))
    else
      super
    end
  end


  def scope
    Pundit.policy_scope!(user, record.class)
  end
end
