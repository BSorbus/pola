class NotificationPoolJob < ApplicationJob
  self.queue_as :notification

	attr_reader :notification_owner, :notification_owner_id

  after_enqueue do 
		owner = self.arguments[0].class.to_s
		owner_id = self.arguments[0].id

    delayed_job = Delayed::Job.find(self.provider_job_id)
    delayed_job.update(reference_id: owner_id, reference_type: owner)
  end


  def perform(rec)
		owner = self.arguments[0].class.to_s
		owner_id = self.arguments[0].id

		# remove previous same jobs 
		Delayed::Job.where(queue: "notification", reference_id: owner_id, reference_type: owner).delete_all

    StatusMailer.new_update_event_email(rec).deliver_later if rec.accesses_users.where(notification_by_email: true).any? || User.joins(:roles).where(users: {notification_by_email: true}).where("'event:create' = ANY (roles.activities)").any?
  end
end
