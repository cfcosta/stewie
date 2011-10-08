module Stewie
  autoload :PluginManager, 'stewie/plugin_manager'
  autoload :IrcProtocolParser, 'stewie/irc_protocol_parser'

  class << self
    def mattr_acessor(name)
      class_eval "def self.#{name}; @@#{name} ||= nil ; end"
      class_eval "def self.#{name}=(value); @@#{name} = value ; end"
    end
  end

  mattr_acessor :server
  mattr_acessor :port
  mattr_acessor :channel
  mattr_acessor :nick
end
