require_relative 'test_helper'

describe "User class" do
	before do
		@user = SlackCLI::User.new(
			"UV7S06J4X", 
			"Lee",
			"Lee Higgins",
			"I'm happy :)",
			":sparkles:"
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