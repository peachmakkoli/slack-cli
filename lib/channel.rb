require_relative 'recipient'

module SlackCLI
  class Channel < Recipient
    attr_reader :topic, :member_count

    def initialize(slack_id:, name:, topic:, member_count:)
      super(slack_id: slack_id, name: name)
      
      @topic = topic
      @member_count = member_count
    end

    def self.list_all
      response = self.get("#{BASE_URL}conversations.list", GET_QUERY)
      
      return response["channels"].map { |channel| new(
        slack_id: channel["id"],
        name: channel["name"],
        topic: channel["topic"]["value"],
        member_count: channel["num_members"]
      )}
    end
  end
end
