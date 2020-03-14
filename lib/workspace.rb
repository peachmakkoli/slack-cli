module SlackCLI
	class Workspace
		attr_reader :users, :channels, :selected
		
		def initialize
			@users = User.list_all
			@channels = Channel.list_all
			@selected = nil
		end

		def select_channel(slack_id)
			# When I type select channel, I should be able to supply a channel name or Slack ID. The corresponding channel should be the "selected" recipient.
				# search through the channels array for a channel matching the slack_id, return that channel
			# For selecting both users and channels, if no user/channel has that name or ID, the program should let me know and return to the main command loop.
				# raise SlackApiError with rescue
		end

		def select_user
			# When I type select user, I should be able to supply a username or Slack ID. The corresponding user should be the "selected" recipient. 
				# search through the users array for a user matching the slack_id, return that user
			# For selecting both users and channels, if no user/channel has that name or ID, the program should let me know and return to the main command loop.
				# raise SlackApiError with rescue
		end

		def show_details
			# If no recipient is currently selected, the program should let me know and return to the main command prompt.
		end

		def send_message

		end

	end
end