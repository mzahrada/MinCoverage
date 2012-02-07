module MinCoverage
  # Defines one instance of MinCoverage problem.
  class Instance
    # Error message raised when number of subsegments of ouf range.
    SEGMENTS_COUNT_OUT_OF_RANGE = 'The count of segments must be from 1 to 5000. It was %s.'

    # Right coordinate of segment we want to cover - <tt><0,m></tt>.
    attr_reader :m
    # List of subsegments of Segment object we have to try to cover the whole segment.
    attr_reader :segment_list

    # Creates new Instance. Initializes empty _segment_list_ and _m_.
    # ---
    # * Args::
    #   - _m_ right coordinate of segment we want to cover
    def initialize(m)
      raise ArgumentError.new(SEGMENTS_COUNT_OUT_OF_RANGE % m.to_s) if m < 1 || m > 5000
      @m = m  # segment to cover is 0..m
      @segment_list = []
    end

    # Adds Segment to _segment_list_.
    # ---
    # * Args::
    #   - _segment_ subsegment we want to add to _segment_list_
    def add_segment(segment)
      @segment_list << segment
    end
  end
end