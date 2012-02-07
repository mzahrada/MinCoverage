$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'mincoverage/covering_solver'
require 'mincoverage/instance'
require 'mincoverage/segment'

class CoveringSolverTest < Test::Unit::TestCase
  def test_solve
    instance = MinCoverage::Instance.new(2)
    instance.add_segment(MinCoverage::Segment.new(-4, 0)) # useless segment
    instance.add_segment(MinCoverage::Segment.new(-1, 1))
    instance.add_segment(MinCoverage::Segment.new(0, 1))
    instance.add_segment(MinCoverage::Segment.new(5, 2))  # useless
    instance.add_segment(MinCoverage::Segment.new(1, 3))
    instance.add_segment(MinCoverage::Segment.new(2, 5))  # useless
    assert_equal("2\n0 1\n1 3", MinCoverage::CoveringSolver.solve(instance))
  end

  def test_solve_empty
    instance = MinCoverage::Instance.new(2)
    instance.add_segment(MinCoverage::Segment.new(-4, 0)) # useless
    assert_equal([0], MinCoverage::CoveringSolver.solve(instance))
  end

  def test_solve_hole
    instance = MinCoverage::Instance.new(3)
    instance.add_segment(MinCoverage::Segment.new(-1, 1))
    instance.add_segment(MinCoverage::Segment.new(0, 1))  # hole between 1 and 2
    instance.add_segment(MinCoverage::Segment.new(2, 3))
    assert_equal([0], MinCoverage::CoveringSolver.solve(instance))
  end

  def test_solve_whole_segment
    instance = MinCoverage::Instance.new(10)
    instance.add_segment(MinCoverage::Segment.new(0, 10))
    instance.add_segment(MinCoverage::Segment.new(0, 10))
    assert_equal("1\n0 10", MinCoverage::CoveringSolver.solve(instance))
  end

  def test_remove_useless_items
    m = 2
    segments = []
    segments << MinCoverage::Segment.new(2, 0)  # useless
    segments << MinCoverage::Segment.new(-4, 0) # useless
    segments << MinCoverage::Segment.new(2, 5)  # useless
    s = MinCoverage::Segment.new(0, 1)
    segments << s
    assert_equal([s], MinCoverage::CoveringSolver.remove_useless_items!(segments, m))
  end

  def test_sort_by
    a = MinCoverage::Segment.new(2, 4)  # 3.
    b = MinCoverage::Segment.new(-1, 3) # 1.
    c = MinCoverage::Segment.new(2, 5)  # 4.
    d = MinCoverage::Segment.new(0, 1)  # 2.
    segments = [a,b,c,d]
    assert_equal([b,d,a,c], MinCoverage::CoveringSolver.sort_items!(segments))
  end
end
