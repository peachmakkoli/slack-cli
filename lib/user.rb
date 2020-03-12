require_relative 'recipient'

module SlackCLI
	class User < Recipient
		attr_reader :real_name, :status_text, :status_emoji

		def intitialize(slack_id, name, real_name, status_text, status_emoji)
			super(slack_id, name)
			@real_name = real_name
			@status_text = status_text
			@status_emoji = status_emoji
		end
		
	end
end
