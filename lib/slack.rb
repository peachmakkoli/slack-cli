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
		puts "\nWhat would you like to do? \n1) list users \n2) list channels \n3) quit"
		option = gets.chomp.downcase

		case option
			when "1", "list users"
				tp list_users, :slack_id, :name, :real_name, :status_text, :status_emoji
			when "2", "list channels"
				tp list_channels, :slack_id, :name, :topic, :member_count
			when "3", "quit"
				break
		end
	end

  puts "Thank you for using Lee's Slack CLI!"
end

main if __FILE__ == $PROGRAM_NAME