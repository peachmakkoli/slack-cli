require_relative 'test_helper'

describe "Recipient class" do
  USER_KEY = ENV["USER_TOKEN"]
  BOT_KEY = ENV["BOT_TOKEN"]
  BASE_URL = "https://slack.com/api/"
  GET_QUERY = {
    query: {
      token: BOT_KEY,
    }
  }

  before do
    @recipient = SlackCLI::Recipient.new(
      slack_id: "UV7S06J4X", 
      name: "Lee"
    )
  end

  describe "Recipient instantiation" do
    it "is an instance of Recipient" do
      expect(@recipient).must_be_kind_of SlackCLI::Recipient
    end

    it "is set up for specific attributes and data types" do
      [:slack_id, :name].each do |attribute|
        expect(@recipient).must_respond_to attribute
      end

      expect(@recipient.slack_id).must_be_kind_of String
      expect(@recipient.name).must_be_kind_of String
    end
  end

  describe "#send_message" do
    before do
      @channel = SlackCLI::Channel.new(
        slack_id: "CUT6YR3LJ", 
        name: "lees-test-channel",
        topic: "For having fun with the Slack API!!",
        member_count: 2
      )
      @user = SlackCLI::User.new(
        slack_id: "UV7S06J4X", 
        name: "Lee",
        real_name: "Lee Higgins",
        status_text: "I'm happy :)",
        status_emoji: ":sparkles:"
      )
    end

    it "can send a message to a channel" do
      VCR.use_cassette("post-message-endpoint") do
        response = @channel.send_message("Don't you think dreams and the internet are similar?")
        expect(response.code).must_equal 200
        expect(response["ok"]).must_equal true
        expect(response["message"]["text"]).must_equal "Don't you think dreams and the internet are similar?"
      end
    end

    it "can send a message to a user" do
      VCR.use_cassette("post-message-endpoint") do
        response = @user.send_message("They are both areas where the repressed conscious mind vents.")
        expect(response.code).must_equal 200
        expect(response["ok"]).must_equal true
        expect(response["message"]["text"]).must_equal "They are both areas where the repressed conscious mind vents."
      end
    end

    it "can set the bot's username" do
      VCR.use_cassette("post-message-endpoint") do
        response = @user.send_message("Hello! My name is Paprika.")
        expect(response["message"]["username"]).must_equal "Paprika"
      end
    end
    
    it "throws an exception when a call fails" do
      VCR.use_cassette("post-message-endpoint") do
        # tests user
        expect{@user.send_message("")}.must_raise SlackAPIError
        # tests channel
        expect{@channel.send_message("")}.must_raise SlackAPIError
      end
    end

    it "throws an exception if the text is only spaces" do
      VCR.use_cassette("post-message-endpoint") do
        expect{@user.send_message(" ")}.must_raise SlackAPIError
        expect{@user.send_message("         ")}.must_raise SlackAPIError
      end
    end
  end

  # tests for #self.get can be found in the subclasses!
end