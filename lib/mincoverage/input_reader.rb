require_relative 'instance'
require_relative 'segment'

module MinCoverage

  # Class for reading input from I/O stream for MinCoverage module.
  # ---
  # Expected input:
  # 
  #     2       .. number of instances
  #
  #     4       .. m = segment's right variable <0,m> .. <0,4>
  #     -2 1    .. subsegment 1
  #     1 2     .. subsegment 2
  #     1 5     ..
  #     0 0     .. end of instance [m=4,segs=[<-2,1>,<1,2>,<1,5>]]
  #
  #     3       .. second instance .. <0,3>
  #     -2 1
  #     0 2
  #     1 6
  #     0 0     .. [m=3,segs=[<-2,1>,<0,2>,<1,6>]]
  # 
  class InputReader

    # Error message raised when first line of input not integer
    INSTANCES_COUNT_EXPECTED = 'Number of instances expected in first line.'

    # Error message raised when blank line expected in I/O but was not blank.
    BLANK_EXPECTED = 'Blank line expected.'

    # Creates array of Instance objects which are parsed from I/O stream.
    # ---
    # * Returns::
    #   - array of Instance objects
    def get_instances
      instances_count = gets.to_i
      raise InputFormatError.new(INSTANCES_COUNT_EXPECTED) if instances_count < 1

      instance_list = []

      1.upto(instances_count) { |i|
        raise InputFormatError.new(BLANK_EXPECTED) if gets.chomp != ''

        m = gets.to_i
        instance = Instance.new(m)

        until (line = gets.chomp.split(" ")) == ["0","0"]
          instance.add_segment(Segment.new(line[0].to_i, line[1].to_i))
        end
        instance_list << instance
      }
      return instance_list
    end

    # Error class for signalizing input errors.
    class InputFormatError < StandardError
    end
  end
end
