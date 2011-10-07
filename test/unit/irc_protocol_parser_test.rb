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

  def test_parse_channel_join
    message = ':WiZ JOIN #Twilight_zone'
    assert_equal [:join, 'WiZ', '#Twilight_zone'], @protocol.parse(message)
  end

  def test_parse_channel_nick_change
    assert_equal [:nick, 'WiZ', 'Kilroy'], @protocol.parse(':WiZ NICK Kilroy')
  end

  def test_parse_channel_server_quit
    message = ':Trillian SQUIT localhost :Bye!'
    assert_equal [:squit, 'Trillian', 'localhost', 'Bye!'], @protocol.parse(message)
  end
end
