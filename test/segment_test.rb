$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'mincoverage/segment'

class SegmentTest < Test::Unit::TestCase
  def test_new
    segment = MinCoverage::Segment.new(1, 3)
    assert_equal(1, segment.left)
    assert_equal(3, segment.right)
    assert_equal(2, segment.size)
  end

  def test_new_error
    assert_raise(ArgumentError) { MinCoverage::Segment.new("a", 3) }
    assert_raise(ArgumentError) { MinCoverage::Segment.new(50002, 3) }
    assert_raise(ArgumentError) { MinCoverage::Segment.new(1, 3.3) }
  end

  def test_to_s
    segment = MinCoverage::Segment.new(1, 3)
    assert_equal("1 3", segment.to_s)
  end

  def test_my_to_s
    segment = MinCoverage::Segment.new(1, 3)
    assert_equal("<1,3>|2|", segment.my_to_s)
  end
end
