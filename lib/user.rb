require_relative 'recipient'

module SlackCLI
	class User < Recipient
		GETUSER_QUERY = {
			query: {
				token: BOT_KEY,
				user: @slack_id
			}
		}

		attr_reader :real_name, :status_text, :status_emoji

		def initialize(slack_id:, name:, real_name:, status_text:, status_emoji:)
			super(slack_id: slack_id, name: name)
			
			@real_name = real_name
			@status_text = status_text
			@status_emoji = status_emoji
		end

		def details
			return self.get(GETUSER_URL, GETUSER_QUERY)
		end

		def self.list_all
			response = self.get(GETALLUSERS_URL, GETALL_QUERY)

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
