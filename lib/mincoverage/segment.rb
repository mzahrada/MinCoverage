module MinCoverage
  # Represents subsegment of _x_ axis. Has _left_ and _right_ coordinate.
  class Segment
    # Error message raised when one of coordinates not integer.
    COORDINATES_NOT_INT = 'Coordinates must be integers.'
    # Error message raised when one of coordinates out of range.
    COORDINATES_OUT_OF_RANGE = 'Coordinates out of range (max 50000).'
    # Max value of coordinate.
    COORDINATE_MAX = 50000

    # Left coordinate.
    attr_reader :left
    # Right coordinate.
    attr_reader :right
    # Segmet's size (<tt>right - left</tt>).
    attr_reader :size

    # Creates new Segment. Initializes _left_ and _right_ coordinate and count _size_.
    # ---
    # * Args::
    #   - _left_ left coordinate
    #   - _right_ right coordinate
    def initialize(left, right)
      raise ArgumentError.new(COORDINATES_NOT_INT) if !left.is_a?(Integer) || !right.is_a?(Integer)
      raise ArgumentError.new(COORDINATES_OUT_OF_RANGE) if left > COORDINATE_MAX || right > COORDINATE_MAX
      @left = left
      @right = right
      @size = (left - right).abs
    end

    # Defines method which transforms object attributes to string for _testing_.
    # ---
    # Returns:
    #
    #     <1,5>|4|       .. "<left,right>|size|"
    def my_to_s
      return "<" + left.to_s + "," + right.to_s + ">|" + size.to_s + "|"
    end

    # Defines method which transforms object attributes to string for _output_.
    # ---
    # Returns:
    #
    #     1 5       .. "left right"
    def to_s
      return left.to_s + " " + right.to_s
    end
  end
end
