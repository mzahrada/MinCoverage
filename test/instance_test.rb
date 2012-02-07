$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'mincoverage/instance'
require 'mincoverage/segment'

class InstanceTest < Test::Unit::TestCase
  def test_instance
    instance = MinCoverage::Instance.new(5)
    instance.add_segment(MinCoverage::Segment.new(-1, 2))
    instance.add_segment(MinCoverage::Segment.new(3, 5))
    assert_equal(5, instance.m)
    assert_equal(2, instance.segment_list.size)
  end
  def test_new_error
    assert_raise(ArgumentError) { MinCoverage::Instance.new(5001) }
  end
end