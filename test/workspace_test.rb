require_relative 'test_helper'

describe "Workspace class" do
	before do
		@workspace = SlackCLI::Workspace.new
	end

	describe "Workspace instantiation" do
		it "is an instance of Workspace" do
			expect(@workspace).must_be_kind_of SlackCLI::Workspace
		end

		it "is set up for specific attributes and data types" do
      [:users, :channels].each do |attribute|
        expect(@workspace).must_respond_to attribute
      end

      expect(@workspace.users).must_be_kind_of Array
			expect(@workspace.channels).must_be_kind_of Array
		end
	end
end