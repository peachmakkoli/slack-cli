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
	
	def select_user_option
		puts "Please enter the user ID:"
		id = gets.chomp.upcase
		begin
			@workspace.select_user(id)
		rescue SlackAPIError => error
			puts error.message
		else
			puts "Ok! \"#{@workspace.selected.name}\" selected."
		end
	end

	def select_channel_option
		puts "Please enter the channel ID:"
		id = gets.chomp.upcase
		begin
			@workspace.select_channel(id)
		rescue SlackAPIError => error
			puts error.message
		else
			puts "Ok! \"#{@workspace.selected.name}\" selected."
		end
	end

	def show_details_option
		begin
			@workspace.show_details
		rescue SlackAPIError => error
			puts error.message
		end

		if @workspace.selected.class == SlackCLI::User 
			tp @workspace.show_details, :slack_id, :name, :real_name, :status_text, :status_emoji
		elsif @workspace.selected.class == SlackCLI::Channel
			tp @workspace.show_details, :slack_id, :name, :topic, :member_count
		end
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
				select_user_option
			when "4", "select channel"
				select_channel_option
			when "5", "details"
				show_details_option
			when "6", "quit"
				break
			else 
				puts "Sorry, that's not an option!"
		end
	end

  puts "Thank you for using Lee's Slack CLI!"
end

main if __FILE__ == $PROGRAM_NAME