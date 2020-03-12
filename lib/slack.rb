#!/usr/bin/env ruby

require 'table_print'
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  def list_users
  # When I type list users, I should see a list of all the users in the Slack workspace. This list should include username, real name, and Slack ID.
  end

  def list_channels
  # When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.
  end

  loop do
		puts "\nWhat would you like to do? \n1) list users \n2) list channels \n3) quit"
		option = gets.chomp.downcase

		case option
			when "1", "list users"
				tp list_users
			when "2", "list channels"
				tp list_channels
			when "3", "quit"
				break
		end
	end

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME