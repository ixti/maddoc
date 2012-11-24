# stdlib
require 'pathname'


# internal
require 'maddoc/version'
require 'maddoc/runner'


module MadDoc
  def self.root
    @root ||= Pathname.new File.realpath(File.join(__FILE__, '../..'))
  end
end
