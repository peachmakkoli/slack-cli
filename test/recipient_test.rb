require_relative 'test_helper'

describe "Recipient class" do
	before do
		@recipient = Recipient.new(
			slack_id: "UV7S06J4X", 
			name: "Lee"
		)
	end

	describe "Recipient instantiation" do
		it "is an instance of Recipient" do
			expect(@recipient).must_be_kind_of Recipient
		end

		it "is set up for specific attributes and data types" do
      [:slack_id, :name].each do |attribute|
        expect(@recipient).must_respond_to attribute
      end

      expect(@recipient.slack_id).must_be_kind_of String
			expect(@recipient.name).must_be_kind_of String
		end
	end
end