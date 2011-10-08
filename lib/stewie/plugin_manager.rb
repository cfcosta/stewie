module Stewie
  class PluginManager
    attr_reader :plugins

    def initialize
      @plugins = []
    end

    def register(plugin)
      @plugins << plugin
    end

    def reset_definitions
      @plugins = []
    end
  end
end
