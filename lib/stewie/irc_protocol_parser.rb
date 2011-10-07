module Stewie
  class IrcProtocolParser
    def parse(message)
      case message
      when /:.* \d{3} .* :.*/
        parsed = message.match(/:(?<sender>.*) (?<code>\d{3}) (?<target>.*) :(?<message>.*)/)
        [:raw, parsed[:code], parsed[:sender], parsed[:target], parsed[:message]]
      when /PING/
        parsed = message.match(/PING :(?<from>.*)/)
        [:ping, parsed[:from]]
      when /MODE/
        parsed = message.match(/:(?<from>.*) MODE (?<to>.*) :(?<mode>.*)/)
        [:mode, parsed[:from], parsed[:to], parsed[:mode]]
      when /NICK/
        parsed = message.match(/:(?<old_nick>.*) NICK (?<new_nick>.*)/)
        [:nick, parsed[:old_nick], parsed[:new_nick]]
      when /JOIN/
        parsed = message.match(/:(?<nick>.*)!(?<host>.*) JOIN (?<channel>.*)/)
        [:join, parsed[:nick], parsed[:host], parsed[:channel]]
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
      when /PRIVMSG/
        parsed = message.match(/:(?<caller>.*) PRIVMSG (?<receiver>.*) :(?<message>.*)/)
        [:privmsg, parsed[:caller], parsed[:receiver], parsed[:message]]
      when /NOTICE/
        parsed = message.match(/:(?<caller>.*) NOTICE (?<receiver>.*) :(?<message>.*)/)
        [:notice, parsed[:caller], parsed[:receiver], parsed[:message]]
      when /USER/
        parsed = message.match(/:(?<nick>.*) USER (?<username>.*) (?<hostname>.*) (?<servername>.*) :(?<realname>.*)/)
        [:user, parsed[:nick], parsed[:username], parsed[:hostname], parsed[:servername], parsed[:realname]]
      end
    end
  end
end
