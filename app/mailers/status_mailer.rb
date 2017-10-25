class StatusMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_provider_username
  default cc: Rails.application.secrets.email_provider_username


  def event_status_email(user, event)
    @url  = Rails.application.secrets.domain_name
    @user = user
    @event = event
    attachments.inline['logo.jpg'] = File.read("app/assets/images/pola.png")

#    mail(to: user.email, subject: "POLA - #{@event.try(:title)} (#{@event.project.try(:number)})" )
  end

  def project_status_email(user, project)
    @url  = Rails.application.secrets.domain_name
    @user = user
    @project = project
    attachments.inline['logo.jpg'] = File.read("app/assets/images/pola.png")

#    mail(to: user.email, subject: "POLA - projekt #{@project.try(:number)} (#{@project.customer.try(:name)})" )
  end

  def new_comment_email(comment)
    @comment = comment
    emails = comment.event.accesses_users.order(:name).flat_map {|row| row.email }.join(',')
    attachments.inline['logo.jpg'] = File.read("app/assets/images/pola.png")
#    mail(to: emails, subject: "POLA - dotyczy zadania: #{@comment.event.try(:title)}" )
  end

  def new_update_event_email(event)
    @event = event
    emails = event.accesses_users.order(:name).flat_map {|row| row.email }.join(',')
    attachments.inline['logo.jpg'] = File.read("app/assets/images/pola.png")
#    mail(to: emails, subject: "POLA - dotyczy zadania: #{@event.try(:title)}" )
  end

end

# preview
# http://localhost:3000/rails/mailers/status_mailer/project_status_email.html