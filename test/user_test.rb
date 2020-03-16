require_relative 'test_helper'

describe "User class" do
  describe "User instantiation" do
    before do
      @user = SlackCLI::User.new(
        slack_id: "UV7S06J4X", 
        name: "Lee",
        real_name: "Lee Higgins",
        status_text: "I'm happy :)",
        status_emoji: ":sparkles:"
      )
    end
  
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

  describe "#self.get" do
    it "can get a list of users" do
      VCR.use_cassette("users-list-endpoint") do
        response = SlackCLI::User.get("#{BASE_URL}users.list", GET_QUERY)
        expect(response.code).must_equal 200
        expect(response["ok"]).must_equal true
        expect(response["members"]).must_be_kind_of Array
      end
    end
    
    it "throws an exception when a call fails" do
      VCR.use_cassette("users-list-endpoint") do
        expect{SlackCLI::User.get("#{BASE_URL}bogus.endpoint", GET_QUERY)}.must_raise SlackAPIError
      end
    end
  end

  describe "#self.list_all" do
    it "returns all the users" do
      VCR.use_cassette("users-list-endpoint") do
        users = SlackCLI::User.list_all
        expect(users).must_be_kind_of Array
        expect(users.length).must_equal 12
      end
    end

    it "returns the correct information for the first user" do
      VCR.use_cassette("users-list-endpoint") do
        users = SlackCLI::User.list_all
        expect(users[0].slack_id).must_equal "USLACKBOT"
        expect(users[0].name).must_equal "slackbot"
        expect(users[0].real_name).must_equal "Slackbot"
        expect(users[0].status_text).must_equal ""
        expect(users[0].status_emoji).must_equal ""
      end
    end

    it "returns the correct information for the last user" do
      VCR.use_cassette("users-list-endpoint") do
        users = SlackCLI::User.list_all
        expect(users[-1].slack_id).must_equal "U0102NT1RE3"
        expect(users[-1].name).must_equal "space_faezeh_slack_ap"
        expect(users[-1].real_name).must_equal "space_faezeh_slack_ap"
        expect(users[-1].status_text).must_equal ""
        expect(users[-1].status_emoji).must_equal ""
      end
    end
  end
end