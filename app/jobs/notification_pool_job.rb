class NotificationPoolJob < ApplicationJob
	self.queue_adapter = :async
  self.queue_as :low_priority


  def perform(rec)
    puts '========================================================================================='
    puts "From send_notification_to_pool model:#{rec.class.to_s} id:#{rec.id} "
    puts '========================================================================================='    
  end
end
