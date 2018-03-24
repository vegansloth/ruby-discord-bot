module Discord
  module Commands
    extend Discordrb::Commands::CommandContainer

    @admin_roles = [171956350438342657, 414400751574450177]

    desc = "pong!"
    command :ping, description: desc do |event|
      "pong! (#{Time.now - event.timestamp}s)"
    end

    command :prune, help_available: false do |event, amount|
      # TODO
    end

    # TODO: Allow certain roles to use it.
    roles = []
    desc  = "Sends a message to the specified channel"
    usage = "!say #channel some message"
    command :say, min_args: 2, description: desc, usage: usage, required_roles: roles do |event, channel, *message|
      channel = channel.gsub("<#", "").to_i
      $bot.send_message channel, message.join(" ")
    end

    # This can be VERY dangerous in the wrong hands. Just allow the owner or very specific people to use it.
    command :eval, help_available: false do |event, *code|
      event.respond "Only the owner can do this" and break unless "#{event.user.id}" == configatron.discord_owner_id

      begin
        eval code.join(' ')
      rescue => e
        "Error 😭: ```#{e}```"
      end
    end

    # Meant to use locally only.
    command :debug, help_available: false do |event, *args|
      # binding.pry
    end
  end
end