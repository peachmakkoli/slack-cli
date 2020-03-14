require_relative 'recipient'

module SlackCLI
	class Channel < Recipient
		attr_reader :topic, :member_count

		def initialize(slack_id:, name:, topic:, member_count:)
			super(slack_id: slack_id, name: name)
			
			@topic = topic
			@member_count = member_count
		end

		def details
			# When I type details, the program should print out details for the currently selected recipient. What information is printed depends on whether it's a channel or a user.
		end

		def self.list_all
			response = self.get(GETCHANNEL_URL, GET_QUERY)
						
			# case response.code
			# when 400, 401, 403, 404, 500
			# 	raise SlackApiError, response["reason"]
			# end

			return response["channels"].map { |channel| new(
				slack_id: channel["id"],
				name: channel["name"],
				topic: channel["topic"]["value"],
				member_count: channel["num_members"]
			)}
		end
	end
end
