$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'mincoverage/input_reader'

class InputReaderTest < Test::Unit::TestCase

  def test_get_instances
    instances = MinCoverage::InputReader.get_instances
    assert_equal(2, instances.size)
    assert_equal(1, instances[0].m)
    assert_equal(-1, instances[0].segment_list[0].left)
  end
end
