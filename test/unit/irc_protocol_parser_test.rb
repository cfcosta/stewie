require 'test_helper'

class IrcProtocolParserTest < MiniTest::Unit::TestCase
  def setup
    @protocol = Stewie::IrcProtocolParser.new
  end

  def test_parse_user_connection
    message = "USER guest tolmoon tolsun :Ronnie Reagan"
    assert_equal [:user, 'guest', 'tolmoon', 'toolsun', 'Ronnie Reagan'], @protocol.parse(message)
  end

  def test_parse_channel_nick_change
    assert_equal [:nick, 'WiZ', 'Kilroy'], @protocol.parse(':WiZ NICK Kilroy')
  end

  def test_parse_channel_server_quit
    message = ':Trillian SQUIT localhost :Bye!'
    assert_equal [:squit, 'Trillian', 'localhost', 'Bye!'], @protocol.parse(message)
  end
end
