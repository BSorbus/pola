class NotificationPoolJob < ApplicationJob
	self.queue_adapter = :async
  self.queue_as :low_priority

	before_enqueue :puts_before_enqueue

	before_perform :puts_before_perform

	def enqueue(options = {})
    puts '////////////////////////////////////////////////////////////////////////////////////////'
    puts 'enqueue super'
    puts "puts self.arguments: #{self.arguments}"
    puts "puts self.serialize_arguments(arguments): #{serialize_arguments(self.arguments)}"
   	puts "puts self.class.name: #{self.class.name}"
    puts "puts self.class.queue_name: #{self.class.queue_name}"
   	puts "puts self.job_id: #{self.job_id}"
   	puts "puts self.provider_job_id: #{self.provider_job_id}"
   	puts "puts sef.inspect: #{self.inspect}"
   	#puts "puts GlobalID.find('gid://pola/Event/500'): #{GlobalID.find('gid://pola/Event/500')}"
   	puts "puts sef.inspect: #{GlobalID.find( 'gid://pola/Event/500' )}"
    puts '////////////////////////////////////////////////////////////////////////////////////////'
		super
	end

  queue_as do
    puts '****************************************************************************************'
    puts "QUEUE_AS"
    puts "puts self.arguments: #{self.arguments}"
    puts "puts self.serialize_arguments(arguments): #{serialize_arguments(self.arguments)}"
   	puts "puts self.class.name: #{self.class.name}"
    puts "puts self.class.queue_name: #{self.class.queue_name}"
   	puts "puts self.job_id: #{self.job_id}"
   	puts "puts self.provider_job_id: #{self.provider_job_id}"
   	puts "puts sef.inspect: #{self.inspect}"
    puts '****************************************************************************************'
    # send_model = self.arguments[0].class.to_s
    # send_model_id = self.arguments[0].id
    # "#{send_model}-#{send_model_id}"
  end

  def puts_before_enqueue
    puts '-----------------------------------------------------------------------------------------'
    puts "BEFORE_ENQUEUE"
    puts "puts self.serialize_arguments(arguments): #{serialize_arguments(self.arguments)}"
   	puts "puts self.class.name: #{self.class.name}"
    puts "puts self.class.queue_name: #{self.class.queue_name}"
   	puts "puts self.job_id: #{self.job_id}"
   	puts "puts self.provider_job_id: #{self.provider_job_id}"
   	puts "puts sef.inspect: #{self.inspect}"
    puts '-----------------------------------------------------------------------------------------'
  end

  def puts_before_perform
    puts '-----------------------------------------------------------------------------------------'
    puts "BEFORE_PERFORM"
    puts "puts self.serialize_arguments(arguments): #{serialize_arguments(self.arguments)}"
   	puts "puts self.class.name: #{self.class.name}"
    puts "puts self.class.queue_name: #{self.class.queue_name}"
   	puts "puts self.job_id: #{self.job_id}"
   	puts "puts self.provider_job_id: #{self.provider_job_id}"
   	puts "puts sef.inspect: #{self.inspect}"
    puts '-----------------------------------------------------------------------------------------'  	
  end

  def perform(rec)
    puts '========================================================================================='
    puts "From send_notification_to_pool model:#{rec.class.to_s} id:#{rec.id} "
    puts '========================================================================================='    
  end
end
