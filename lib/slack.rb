#!/usr/bin/env ruby

require 'table_print'
require 'httparty'
require 'dotenv'
Dotenv.load

require_relative 'workspace'
require_relative 'recipient'
require_relative 'channel'
require_relative 'user'

def main
  puts "Welcome to Lee's Slack CLI!"
  @workspace = SlackCLI::Workspace.new

  def list_users
  return @workspace.users
  end

  def list_channels
  return @workspace.channels
  end

  loop do
		puts "\nWhat would you like to do? \n1) list users \n2) list channels \n3) select user \n4) select channel \n5) details \n6) quit"
		option = gets.chomp.downcase

		case option
			when "1", "list users"
				tp list_users, :slack_id, :name, :real_name, :status_text, :status_emoji
			when "2", "list channels"
				tp list_channels, :slack_id, :name, :topic, :member_count
			when "3", "select user"
				# When I type select user, I should be able to supply a username or Slack ID. The corresponding user should be the "selected" recipient.
			when "4", "select channel"
				# When I type select channel, I should be able to supply a channel name or Slack ID. The corresponding channel should be the "selected" recipient.
			when "5", "details"
				# When I type details, the program should print out details for the currently selected recipient. What information is printed depends on whether it's a channel or a user.
				# If no recipient is currently selected, the program should let me know and return to the main command prompt.
			when "6", "quit"
				break
			else 
				puts "Option not recognized! Please try again."
		end
	end

  puts "Thank you for using Lee's Slack CLI!"
end

main if __FILE__ == $PROGRAM_NAME