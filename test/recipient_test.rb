require_relative 'test_helper'

describe "Recipient class" do
	API_KEY = ENV["SLACK_TOKEN"]
	BASE_URL = "https://slack.com/api/"
	POST_URL = "#{BASE_URL}chat.postMessage"
	GETUSER_URL = "#{BASE_URL}users.list"
	GETCHANNEL_URL = "#{BASE_URL}conversations.list"
	GET_QUERY = {
		query: {
			token: API_KEY,
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

	describe "#self.get" do
		it "can get a list of users" do
			VCR.use_cassette("users-list-endpoint") do
				response = SlackCLI::Recipient.get(GETUSER_URL, GET_QUERY)
				expect(response.code).must_equal 200
				expect(response["ok"]).must_equal true
				expect(response["members"]).must_be_kind_of Array
			end
		end

		it "can get a list of channels" do
			VCR.use_cassette("channels-list-endpoint") do
				response = SlackCLI::Recipient.get(GETCHANNEL_URL, GET_QUERY)
				expect(response.code).must_equal 200
				expect(response["ok"]).must_equal true
				expect(response["channels"]).must_be_kind_of Array
			end
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