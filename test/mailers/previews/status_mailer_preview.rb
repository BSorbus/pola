# Preview all emails at http://localhost:3000/rails/mailers/status_mailer
class StatusMailerPreview < ActionMailer::Preview



  # def project_status_email(user, project)
  def project_status_email
    e = Event.last
    user = e.accessorizations.first.user
    message = "Test message"
    StatusMailer.project_status_email(user, e.project)
  end


  # def new_comment_email(comment)
  def new_comment_email
    @comment = Comment.last
    StatusMailer.new_comment_email(@comment)
  end

  # def new_update_event_email(event)
  def new_update_event_email
    @event = Event.last
    StatusMailer.new_update_event_email(@event)
  end

end
