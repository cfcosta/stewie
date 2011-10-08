require 'test_helper'
require 'stewie/plugin_manager'

class PluginManagerTest < MiniTest::Unit::TestCase
  def setup
    @plugin_manager = Stewie::PluginManager.new
  end

  def test_plugin_register
    plugin = Object.new

    assert_empty @plugin_manager.plugins
    @plugin_manager.register plugin
    assert_includes @plugin_manager.plugins, plugin
  end

  def test_reset_definitions
    plugin = Object.new
    @plugin_manager.register plugin
    @plugin_manager.reset_definitions
    assert_empty @plugin_manager.plugins
  end
end
