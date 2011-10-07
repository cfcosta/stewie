require 'test_helper'
require 'stewie/irc_protocol_parser'

class IrcProtocolParserTest < MiniTest::Unit::TestCase
  def setup
    @parser = Stewie::IrcProtocolParser.new
  end

  def test_parse_user_connection
    message = ':ronnie USER guest tolmoon toolsun :Ronnie Reagan'
    assert_equal [:user, 'ronnie', 'guest', 'tolmoon', 'toolsun', 'Ronnie Reagan'], @parser.parse(message)
  end

  def test_parse_ping
    message = 'PING :WiZ'
    assert_equal [:ping, 'WiZ'], @parser.parse(message)
  end

  def test_parse_raw_messages
    message = ':sendak.freenode.net 376 john :End of /MOTD command.'
    assert_equal [:raw, '376', 'sendak.freenode.net', 'john', 'End of /MOTD command.'], @parser.parse(message)
  end

  def test_parse_raw_channel_list
    message = ":hitchcock.freenode.net 353 john = #bottest :john mary gary"
    assert_equal [:raw, '353', 'hitchcock.freenode.net', 'john', '#bottest', 'john', 'mary', 'gary'], @parser.parse(message)
  end

  def test_parse_end_of_names_list
    message = ":leguin.freenode.net 366 john #bottest :End of /NAMES list."
    assert_equal [:raw, "366", "leguin.freenode.net", "john", "#bottest", "End of /NAMES list."], @parser.parse(message)
  end

  def test_parse_mode_setting
    message = ':john MODE mary :+i'
    assert_equal [:mode, 'john', 'mary', '+i'], @parser.parse(message)
  end

  def test_parse_channel_join
    message = ':john!~john@unaffiliated/john JOIN #Twilight_zone'
    assert_equal [:join, 'john', '~john@unaffiliated/john', '#Twilight_zone'], @parser.parse(message)
  end

  def test_parse_channel_nick_change
    assert_equal [:nick, 'WiZ', 'Kilroy'], @parser.parse(':WiZ NICK Kilroy')
  end

  def test_parse_topic_change
    message = ':Wiz TOPIC #test :New topic'
    assert_equal [:topic, 'Wiz', '#test', 'New topic'], @parser.parse(message)
  end

  def test_parse_channel_invite
    message = ':Angel INVITE Wiz #Dust'
    assert_equal [:invite, 'Angel', 'Wiz', '#Dust'], @parser.parse(message)
  end

  def test_parse_channel_kick
    message = ':WiZ KICK #Finnish John'
    assert_equal [:kick, 'WiZ', '#Finnish', 'John'], @parser.parse(message)
  end

  def test_parse_private_message
    message = ':Angel PRIVMSG Wiz :You there?'
    assert_equal [:privmsg, 'Angel', 'Wiz', 'You there?'], @parser.parse(message)
  end

  def test_parse_private_message_with_colons
    message = ':Angel PRIVMSG Wiz :You there? :3'
    assert_equal [:privmsg, 'Angel', 'Wiz', 'You there? :3'], @parser.parse(message)
  end

  def test_parse_notice
    message = ":barjavel.freenode.net NOTICE * :*** Checking Ident"
    assert_equal [:notice, 'barjavel.freenode.net', '*', '*** Checking Ident'], @parser.parse(message)
  end

  def test_parse_channel_quit
    message = ':john!~john@unaffiliated/john PART #bottest'
    assert_equal [:part, 'john', '~john@unaffiliated/john', '#bottest'], @parser.parse(message)
  end

  def test_parse_channel_server_quit
    message = ':Trillian SQUIT localhost :Bye!'
    assert_equal [:squit, 'Trillian', 'localhost', 'Bye!'], @parser.parse(message)
  end
end
