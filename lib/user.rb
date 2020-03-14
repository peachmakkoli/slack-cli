require_relative 'recipient'

module SlackCLI
	class User < Recipient
		attr_reader :real_name, :status_text, :status_emoji

		def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
			super(slack_id: slack_id, name: name)
			
			@real_name = real_name
			@status_text = status_text
			@status_emoji = status_emoji
		end

		def details
			# When I type details, the program should print out details for the currently selected recipient. What information is printed depends on whether it's a channel or a user.
		end

		def self.list_all
			response = self.get(GETUSER_URL, GET_QUERY)
			
			# if response.code != 200 || response["ok"] == false
			# 	raise SlackApiError, "We encountered an error: #{response["error"]}"
			# end

			return response["members"].map { |user| new(
				slack_id: user["id"],
				name: user["name"],
				real_name: user["real_name"],
				status_text: user["profile"]["status_text"],
				status_emoji: user["profile"]["status_emoji"]
			)}
		end
		
	end
end
