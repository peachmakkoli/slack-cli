require_relative 'test_helper'

describe "Channel class" do
	before do
		@channel = SlackCLI::Channel.new(
			slack_id: "CUT6YR3LJ", 
			name: "lees-test-channel",
			topic: "Testing the Slack CLI",
			member_count: 2
		)
	end

	describe "Channel instantiation" do
		it "is an instance of Channel" do
			expect(@channel).must_be_kind_of SlackCLI::Channel
		end

		it "is set up for specific attributes and data types" do
      [:slack_id, :name, :topic, :member_count].each do |attribute|
        expect(@channel).must_respond_to attribute
      end

      expect(@channel.slack_id).must_be_kind_of String
			expect(@channel.name).must_be_kind_of String
			expect(@channel.topic).must_be_kind_of String
			expect(@channel.member_count).must_be_kind_of Integer
		end
	end
end