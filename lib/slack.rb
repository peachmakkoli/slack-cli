#!/usr/bin/env ruby

require 'table_print'
require_relative 'workspace'

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  def list_users
  return workspace.users
  end

  def list_channels
  return workspace.channels
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