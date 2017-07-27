class StatusMailer < ActionMailer::Base
  default from: Rails.application.secrets.email_provider_username
  default cc: Rails.application.secrets.email_provider_username


  def project_status_email(user, project)
    @url  = Rails.application.secrets.domain_name
    @user = user
    @project = project
    attachments.inline['logo.jpg'] = File.read("app/assets/images/proca.png")

    mail(to: user.email, subject: "PROCA - projekt #{@project.try(:number)} (#{@project.customer.try(:name)})" )
  end

  def event_status_email(user, event)
    @url  = Rails.application.secrets.domain_name
    @user = user
    @event = event
    attachments.inline['logo.jpg'] = File.read("app/assets/images/proca.png")

    mail(to: user.email, subject: "PROCA - #{@event.try(:title)} (#{@event.project.try(:number)})" )
  end

end

# preview
# http://localhost:3000/rails/mailers/status_mailer/project_status_email.html