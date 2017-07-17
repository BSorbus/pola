# Preview all emails at http://localhost:3000/rails/mailers/status_mailer
class StatusMailerPreview < ActionMailer::Preview


#  def project_status_email(user, project)
  def project_status_email
    user = User.last
    project = user.accesses_projects.first   
    message = "Test message"
    StatusMailer.project_status_email(user, project)
  end


end
