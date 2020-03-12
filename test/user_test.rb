require_relative 'test_helper'

describe "User class" do
	before do
		@user = SlackCLI::User.new(
			slack_id: "UV7S06J4X", 
			name: "Lee",
			real_name: "Lee Higgins",
			status_text: "I'm happy :)",
			status_emoji: ":sparkles:"
		)
	end

	describe "User instantiation" do
		it "is an instance of User" do
			expect(@user).must_be_kind_of SlackCLI::User
		end

		it "is set up for specific attributes and data types" do
      [:slack_id, :name, :real_name, :status_text, :status_emoji].each do |attribute|
        expect(@user).must_respond_to attribute
      end

      expect(@user.slack_id).must_be_kind_of String
			expect(@user.name).must_be_kind_of String
			expect(@user.real_name).must_be_kind_of String
			expect(@user.status_text).must_be_kind_of String
			expect(@user.status_emoji).must_be_kind_of String
		end
	end
end