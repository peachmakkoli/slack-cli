require_relative 'recipient'

module SlackCLI
	class Channel < Recipient
		attr_reader :topic, :member_count

		def intitialize(slack_id, name, topic, member_count)
			super(slack_id, name)
			@topic = topic
			@member_count = member_count
		end
		
	end
end
