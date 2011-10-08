module Stewie
  class IrcProtocolParser
    def parse(message)
      case message
      when /PRIVMSG/
        parsed = message.match(/:(?<caller>.*)!(?<host>.*) PRIVMSG (?<receiver>.*?) :(?<message>.*)/)
        [:privmsg, parsed[:caller], parsed[:host], parsed[:receiver], parsed[:message]]
      when /:.* 353 .* :.*/
        parsed = message.match(/:(?<sender>.*) 353 (?<target>.*) = (?<channel>.*) :(?<nicks>.*)/)
        [:raw, '353', parsed[:sender], parsed[:target], parsed[:channel]] + parsed[:nicks].split(' ')
      when /:.* 366 .* :.*/
        parsed = message.match(/:(?<sender>.*) 366 (?<target>.*) (?<channel>.*) :(?<message>.*)/)
        [:raw, '366', parsed[:sender], parsed[:target], parsed[:channel], parsed[:message]]
      when /:.* \d{3} .* :.*/
        parsed = message.match(/:(?<sender>.*) (?<code>\d{3}) (?<target>.*) :(?<message>.*)/)
        [:raw, parsed[:code], parsed[:sender], parsed[:target], parsed[:message]]
      when /PING/
        parsed = message.match(/PING :(?<from>.*)/)
        [:ping, parsed[:from]]
      when /MODE/
        parsed = message.match(/:(?<from>.*) MODE (?<to>.*) :?(?<mode>.*)/)
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
      when /PART/
        parsed = message.match(/:(?<nick>.*)!(?<host>.*) PART (?<channel>.*)/)
        [:part, parsed[:nick], parsed[:host], parsed[:channel]]
      when /TOPIC/
        parsed = message.match(/:(?<nick>.*) TOPIC (?<channel>.*) :(?<message>.*)/)
        [:topic, parsed[:nick], parsed[:channel], parsed[:message]]
      when /INVITE/
        parsed = message.match(/:(?<inviter>.*) INVITE (?<invited>.*) (?<channel>.*)/)
        [:invite, parsed[:inviter], parsed[:invited], parsed[:channel]]
      when /KICK/
        if parsed = message.match(/:(?<kicker>.*)!(?<host>.*) KICK (?<channel>.*?) (?<kicked>.*?) :(?<reason>.*)/)
          [:kick, parsed[:kicker], parsed[:host], parsed[:channel], parsed[:kicked], parsed[:reason]]
        elsif parsed = message.match(/:(?<kicker>.*)!(?<host>.*) KICK (?<channel>.*) (?<kicked>.*)$/)
          [:kick, parsed[:kicker], parsed[:host], parsed[:channel], parsed[:kicked]]
        end
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
