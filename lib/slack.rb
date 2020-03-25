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
  @workspace = SlackCLI::Workspace.new

  def list_users
    users = @workspace.users
    tp users, :slack_id, :name, :real_name, :status_text, :status_emoji
  end

  def list_channels
    channels = @workspace.channels
    tp channels, :slack_id, :name, :topic, :member_count
  end
  
  def select_user
    puts "Please enter the user ID:"
    id = gets.chomp.upcase
    
    begin
      @workspace.select_user(id)
    rescue SlackAPIError => error
      puts error.message
    else
      puts "Ok! \"#{@workspace.selected.real_name}\" selected."
    end
  end

  def select_channel
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

  def show_details
    begin
      @workspace.show_details
    rescue SlackAPIError => error
      puts error.message
    end

    if @workspace.selected.is_a? SlackCLI::User 
      tp @workspace.show_details, :slack_id, :name, :real_name, :status_text, :status_emoji
    elsif @workspace.selected.is_a? SlackCLI::Channel
      tp @workspace.show_details, :slack_id, :name, :topic, :member_count
    end
  end

  def send_message
    (@workspace.selected.is_a? SlackCLI::User) ? (name = @workspace.selected.real_name) : (name = @workspace.selected.name) # If a user is selected, the user's real_name attribute is assigned to the name variable; otherwise, the name attribute is assigned to the name variable. This was to ensure that user's chosen names are displayed in the program! 

    puts "What would you like to say to #{name}?"
    text = gets.chomp.to_s
    
    begin
      @workspace.selected.send_message(text)
    rescue SlackAPIError => error
      puts error.message
    else
      puts "Your message was successfully sent!"
    end
  end

  puts "Welcome to Lee's Slack CLI!"

  loop do
    puts "\nWhat would you like to do? \n1) list users \n2) list channels \n3) select user \n4) select channel \n5) details \n6) send message \n7) quit"
    option = gets.chomp.downcase

    case option
      when "1", "list users"
        list_users
      when "2", "list channels"
        list_channels
      when "3", "select user"
        select_user
      when "4", "select channel"
        select_channel
      when "5", "details"
        show_details
      when "6", "send message"
        send_message
      when "7", "quit"
        break
      else 
        puts "Sorry, that's not a valid option!"
    end
  end

  puts "Thank you for using Lee's Slack CLI!"
end

main if __FILE__ == $PROGRAM_NAME