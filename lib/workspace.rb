module SlackCLI
  class Workspace
    attr_reader :users, :channels, :selected
    
    def initialize
      @users = User.list_all
      @channels = Channel.list_all
      @selected = nil
    end

    def select_channel(id)
      @selected = (@channels.select { |channel|
        channel.slack_id == id
      }).first
      raise SlackAPIError.new("No channel with that ID was found!") if @selected.nil?
    end

    def select_user(id)
      @selected = (@users.select { |user|
        user.slack_id == id
      }).first
      raise SlackAPIError.new("No user with that ID was found!") if @selected.nil?
    end

    def show_details
      raise SlackAPIError.new("No user or channel was selected!") if @selected.nil?
      return @selected
    end

    def send_message(text)
      raise SlackAPIError.new("No user or channel was selected!") if @selected.nil?
      @selected.send_message(text)
    end

  end
end