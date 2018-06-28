class NotificationPoolJob < ApplicationJob
	self.queue_adapter = :async
  self.queue_as :low_priority

	before_enqueue :puts_before_enqueue

	before_perform :puts_before_perform




  queue_as do
    # puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'
    # puts self.arguments
    # puts 'XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX'    
    # send_model = self.arguments[0].class.to_s
    # send_model_id = self.arguments[0].id
    # "#{send_model}-#{send_model_id}"
  end

  def puts_before_enqueue
    puts '-----------------------------------------------------------------------------------------'
    puts "puts_before_enqueue"
    puts '-----------------------------------------------------------------------------------------'
  end

  def puts_before_perform
    puts '-----------------------------------------------------------------------------------------'
    puts "puts_before_perform"
    puts '-----------------------------------------------------------------------------------------'
  	
  end

  def perform(rec)
    puts '========================================================================================='
    puts "From send_notification_to_pool model:#{rec.class.to_s} id:#{rec.id} "
    puts '========================================================================================='    
  end
end
