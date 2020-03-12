require_relative 'workspace'
#!/usr/bin/env ruby

def main
  puts "Welcome to the Ada Slack CLI!"
  workspace = SlackCLI::Workspace.new

  def list_users
  # When I type list users, I should see a list of all the users in the Slack workspace. This list should include username, real name, and Slack ID.
  end

  def list_channels
  # When I type list channels, I should see a list of all the channels for that workspace. This list should include the channel's name, topic, member count, and Slack ID.
  end

  # When I type quit, the program should exit.
  
  # After completing any command other than quit, the program should reprint the list of commands and ask for another input.

  puts "Thank you for using the Ada Slack CLI"
end

main if __FILE__ == $PROGRAM_NAME