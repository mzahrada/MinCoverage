$:.unshift File.join(File.dirname(__FILE__),'..','lib')

require 'test/unit'
require 'mincoverage/input_reader'

class NewInputReaderTest < Test::Unit::TestCase
  def test_get_instances
    InputFaker.with_fake_input([2, '', 1, "-1 0", "-5 -3", "2 5", "0 0", '', 1, "-1 0", "0 1", "0 0"]) {
			instances = MinCoverage::InputReader.get_instances
      assert_equal(2, instances.size)
      assert_equal(1, instances[0].m)
      assert_equal(-1, instances[0].segment_list[0].left)
      assert_equal(1, instances[1].m)
      assert_equal(1, instances[1].segment_list[1].right)
    }
  end

  def test_instance_count_error
    InputFaker.with_fake_input([0, '', 1, "-1 0", "-5 -3", "2 5", "0 0", '', 1, "-1 0", "0 1", "0 0"]) {
      assert_raise(MinCoverage::InputReader::InputFormatError) { MinCoverage::InputReader.get_instances }
    }
  end

  def test_blank_line_error
    InputFaker.with_fake_input([2, 'xxx', 1, "-1 0", "-5 -3", "2 5", "0 0", '', 1, "-1 0", "0 1", "0 0"]) {
      assert_raise(MinCoverage::InputReader::InputFormatError) { MinCoverage::InputReader.get_instances }
    }
  end
end


class InputFaker
  def initialize(strings)
    @strings = strings
  end

  def gets
    next_string = @strings.shift
    # Uncomment the following line if you'd like to see the faked $stdin#gets
    #p "(DEBUG) Faking #gets with: #{next_string}"
    next_string
  end

  def self.with_fake_input(strings)
    $stdin = new(strings)
    yield
  ensure
    $stdin = STDIN
  end
end