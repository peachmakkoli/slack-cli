module SlackCLI
	class Workspace
		attr_reader :users, :channels
		
		def initialize
			@users = User.list_all
			@channels = Channel.list_all
		end

		def select_channel

		end

		def select_user

		end

		def show_details

		end

		def send_message

		end

	end
end