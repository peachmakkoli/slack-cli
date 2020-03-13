require_relative 'recipient'

module SlackCLI
	class User < Recipient
		GETUSER_URL = "#{BASE_URL}users.list"

		attr_reader :real_name, :status_text, :status_emoji

		def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
			super(slack_id: slack_id, name: name)
			@real_name = real_name
			@status_text = status_text
			@status_emoji = status_emoji
		end

		def details
			# return the attributes of a channel
		end

		def self.list_all
			response = self.get(GETUSER_URL, GET_QUERY)
			return response["members"]
		end
		
	end
end
