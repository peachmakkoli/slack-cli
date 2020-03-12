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
			VCR.use_cassette("slack-users") do
				response = SlackCLI::Recipient.get(GETUSER_URL, GET_QUERY)
				expect(response.code).must_equal 200
				expect(response.parsed_response["ok"]).must_equal true
				expect(response.parsed_response["members"]).must_be_kind_of Array
			end
		end

		it "can get a list of channels" do
			VCR.use_cassette("slack-channels") do
				response = SlackCLI::Recipient.get(GETCHANNEL_URL, GET_QUERY)
				expect(response.code).must_equal 200
				expect(response.parsed_response["ok"]).must_equal true
				expect(response.parsed_response["channels"]).must_be_kind_of Array
			end
		end
	end
end