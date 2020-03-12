require 'httparty'

module SlackCLI	
	class Recipient
		API_KEY = ENV["SLACK_TOKEN"]
		BASE_URL = "https://slack.com/api/"
		POST_URL = "#{BASE_URL}chat.postMessage"
		GET_QUERY = {
			query: {
				token: API_KEY,
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
end