require_relative 'test_helper'

describe "Recipient class" do
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
	GETUSER_QUERY = {
		query: {
			token: BOT_KEY,
			user: self.slack_id
		}
	}
	GETCHANNEL_QUERY = {
		query: {
			token: BOT_KEY,
			channel: self.slack_id
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

	# remove these methods from private so they can be tested?

	# describe "#details" do
	# 	it "raises a NotImplementedError if called" do
	# 		expect{SlackCLI::Recipient.details}.must_raise NotImplementedError
	# 	end
	# end

	# describe "#self.list_all" do
	# 	it "raises a NotImplementedError if called" do
	# 		expect{SlackCLI::Recipient.list_all}.must_raise NotImplementedError
	# 	end
	# end
end