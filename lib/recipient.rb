require 'httparty'

module SlackCLI	
	class Recipient
		USER_KEY = ENV["USER_TOKEN"]
		BOT_KEY = ENV["BOT_TOKEN"]
		BASE_URL = "https://slack.com/api/"
		GETUSER_URL = "#{BASE_URL}users.list"
		GETCHANNEL_URL = "#{BASE_URL}conversations.list"
		POST_URL = "#{BASE_URL}chat.postMessage"
		GET_QUERY = {
			query: {
				token: BOT_KEY,
			}
		}
		
		attr_reader :slack_id, :name

		def initialize(slack_id:, name:)
			@slack_id = slack_id
			@name = name
		end
		
		def send_message(message)

		end

		def self.get(url, params)
			return HTTParty.get(url, params)
		end

		private 

		def details
			raise NotImplementedError, 'Implement me in a subclass!'
		end

		def self.list_all
			raise NotImplementedError, 'Implement me in a subclass!'
		end
	end

	class SlackAPIError < Exception
	end
end