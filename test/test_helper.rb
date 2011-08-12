require "scope"
require "minitest/autorun"

# No matter what's installed, the local lib/statuesque should come first in the load path
$LOAD_PATH << File.expand_path(File.join(File.dirname(__FILE__), "..", "lib"))
require "statuesque"
