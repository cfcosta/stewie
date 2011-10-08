require 'test_helper'
require 'stewie'

class StewieTest < MiniTest::Unit::TestCase
  def swap(what, acessor, value)
    raise ArgumentError unless block_given?
    old_value = what.send(acessor)
    what.send(:"#{acessor}=", value)
    yield
    what.send(:"#{acessor}=", old_value)
  end

  def test_set_the_server
    swap(Stewie, :server, 'irc.freenode.org') { assert_equal 'irc.freenode.org', Stewie.server  }
  end

  def test_set_the_port
    swap(Stewie, :port, 6667) { assert_equal 6667, Stewie.port }
  end

  def test_set_the_channel
    swap(Stewie, :channel, '#stewiebot') { assert_equal '#stewiebot', Stewie.channel }
  end

  def test_set_the_nick
    swap(Stewie, :nick, 'stewiebot') { assert_equal 'stewiebot', Stewie.nick }
  end
end
