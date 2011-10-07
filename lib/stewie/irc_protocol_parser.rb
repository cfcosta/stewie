module Stewie
  class IrcProtocolParser
    def parse(message)
      case message
      when /NICK/
        parsed = message.match /:(?<old_nick>.*) NICK (?<new_nick>.*)/
        [:nick, parsed[:old_nick], parsed[:new_nick]]
      when /SQUIT/
        parsed = message.match /:(?<nick>.*) SQUIT (?<host>.*) :(?<message>.*)/
        [:squit, parsed[:nick], parsed[:host], parsed[:message]]
      when /USER/
        parsed = message.match /:(?<nick>.*) USER (?<username>.*) (?<hostname>.*) (?<servername>.*) :(?<realname>.*)/
        [:user, parsed[:nick], parsed[:username], parsed[:hostname], parsed[:servername], parsed[:realname]]
      end
    end
  end
end
