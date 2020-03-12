require_relative 'recipient'

module SlackCLI
	class Channel < Recipient
		GETCHANNEL_URL = "#{SlackCLI::Recipient::BASE_URL}conversations.list"

		attr_reader :topic, :member_count

		def initialize(slack_id:, name:, topic:, member_count:)
			super(slack_id: slack_id, name: name)
			@topic = topic
			@member_count = member_count
		end

		def details
			# return the attributes of a channel
		end

		def self.list_all
			# call the self.get method with the GETCHANNEL_URL, pass all relevant data from response into the initializer
		end
		
	end
end
