module Stewie
  class IrcProtocolParser
    def parse(message)
      case message
      when /NICK/
        parsed = message.match(/:(?<old_nick>.*) NICK (?<new_nick>.*)/)
        [:nick, parsed[:old_nick], parsed[:new_nick]]
      when /JOIN/
        parsed = message.match(/:(?<nick>.*) JOIN (?<channel>.*)/)
        [:join, parsed[:nick], parsed[:channel]]
      when /SQUIT/
        parsed = message.match(/:(?<nick>.*) SQUIT (?<host>.*) :(?<message>.*)/)
        [:squit, parsed[:nick], parsed[:host], parsed[:message]]
      when /TOPIC/
        parsed = message.match(/:(?<nick>.*) TOPIC (?<channel>.*) :(?<message>.*)/)
        [:topic, parsed[:nick], parsed[:channel], parsed[:message]]
      when /INVITE/
        parsed = message.match(/:(?<inviter>.*) INVITE (?<invited>.*) (?<channel>.*)/)
        [:invite, parsed[:inviter], parsed[:invited], parsed[:channel]]
      when /KICK/
        parsed = message.match(/:(?<kicker>.*) KICK (?<channel>.*) (?<kicked>.*)/)
        [:kick, parsed[:kicker], parsed[:channel], parsed[:kicked]]
      when /USER/
        parsed = message.match(/:(?<nick>.*) USER (?<username>.*) (?<hostname>.*) (?<servername>.*) :(?<realname>.*)/)
        [:user, parsed[:nick], parsed[:username], parsed[:hostname], parsed[:servername], parsed[:realname]]
      end
    end
  end
end
