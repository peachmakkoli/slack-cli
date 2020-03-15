require 'httparty'

module SlackCLI	
	class Recipient
		USER_KEY = ENV["USER_TOKEN"]
		BOT_KEY = ENV["BOT_TOKEN"]
		
		BASE_URL = "https://slack.com/api/"
		GETALLUSERS_URL = "#{BASE_URL}users.list"
		GETALLCHANNELS_URL = "#{BASE_URL}conversations.list"
		GETUSER_URL = "#{BASE_URL}users.info"
		GETCHANNEL_URL = "#{BASE_URL}conversations.info"
		POST_URL = "#{BASE_URL}chat.postMessage"
		
		GETALL_QUERY = {
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
			response = HTTParty.get(url, params)

			raise SlackAPIError.new("We encountered an error: #{response["error"]}") if response.code != 200 || response["ok"] == false
			
			return response
		end

		private 

		def details
			raise NotImplementedError, 'Implement me in a subclass!'
		end

		def self.list_all
			raise NotImplementedError, 'Implement me in a subclass!'
		end
	end
end

class SlackAPIError < Exception
end