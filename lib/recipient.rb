require 'httparty'

module SlackCLI  
  class Recipient
    USER_KEY = ENV["USER_TOKEN"]
    BOT_KEY = ENV["BOT_TOKEN"]
    BASE_URL = "https://slack.com/api/"
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
    
    def send_message(text)
      raise SlackAPIError.new("No text entered!") if text.match(/^\s+$/)

      response = HTTParty.post(
        "#{BASE_URL}chat.postMessage", 
        {
          query: {
            token: BOT_KEY,
            channel: @slack_id,
            text: text,
            username: "Paprika"
          }
        })

      raise SlackAPIError.new("We encountered an error: #{response["error"]}") if response.code != 200 || response["ok"] == false
      
      return response
    end

    def self.get(url, params)
      response = HTTParty.get(url, params)

      raise SlackAPIError.new("We encountered an error: #{response["error"]}") if response.code != 200 || response["ok"] == false
      
      return response
    end

    private 

    def self.list_all
      raise NotImplementedError, 'Implement me in a subclass!'
    end
  end
end

class SlackAPIError < Exception
end