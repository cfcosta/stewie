require 'test_helper'
require 'stewie/irc_protocol_parser.rb'

class IrcProtocolParserTest < MiniTest::Unit::TestCase
  def setup
    @protocol = Stewie::IrcProtocolParser.new
  end

  def test_parse_user_connection
    message = ':ronnie USER guest tolmoon toolsun :Ronnie Reagan'
    assert_equal [:user, 'ronnie', 'guest', 'tolmoon', 'toolsun', 'Ronnie Reagan'], @protocol.parse(message)
  end

  def test_parse_ping
    message = 'PING :WiZ'
    assert_equal [:ping, 'WiZ'], @protocol.parse(message)
  end

  def test_parse_channel_join
    message = ':WiZ JOIN #Twilight_zone'
    assert_equal [:join, 'WiZ', '#Twilight_zone'], @protocol.parse(message)
  end

  def test_parse_channel_nick_change
    assert_equal [:nick, 'WiZ', 'Kilroy'], @protocol.parse(':WiZ NICK Kilroy')
  end

  def test_parse_topic_change
    message = ':Wiz TOPIC #test :New topic'
    assert_equal [:topic, 'Wiz', '#test', 'New topic'], @protocol.parse(message)
  end

  def test_parse_channel_invite
    message = ':Angel INVITE Wiz #Dust'
    assert_equal [:invite, 'Angel', 'Wiz', '#Dust'], @protocol.parse(message)
  end

  def test_parse_channel_kick
    message = ':WiZ KICK #Finnish John'
    assert_equal [:kick, 'WiZ', '#Finnish', 'John'], @protocol.parse(message)
  end

  def test_parse_private_message
    message = ':Angel PRIVMSG Wiz :You there?'
    assert_equal [:privmsg, 'Angel', 'Wiz', 'You there?'], @protocol.parse(message)
  end

  def test_parse_channel_server_quit
    message = ':Trillian SQUIT localhost :Bye!'
    assert_equal [:squit, 'Trillian', 'localhost', 'Bye!'], @protocol.parse(message)
  end
end
