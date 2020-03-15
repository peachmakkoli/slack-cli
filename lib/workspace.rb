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
			return @selected
		end

		def select_user(id)
			@selected = (@users.select { |user|
				user.slack_id == id
			}).first
			raise SlackAPIError.new("No user with that ID was found!") if @selected.nil?
			return @selected
		end

		def show_details
			# If no recipient is currently selected, the program should let me know and return to the main command prompt.
		end

		def send_message

		end

	end
end