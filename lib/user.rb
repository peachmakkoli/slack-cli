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

    def self.list_all
      response = self.get("#{BASE_URL}users.list", GET_QUERY)
      
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
