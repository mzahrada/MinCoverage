require_relative 'input_reader'
require_relative 'covering_solver'

# Module that counts minimal coverage of segment <tt><0,m></tt> by subsegments
# loaded from input.
#
# Author:: Martin Zahradnicky  (mailto:zahrama8@fit.cvut.cz)
module MinCoverage

  # Runner class for MinCoverage module.
  class Runner

    # Main method for running MinCoverage module.
    # ---
    # * Returns::
    #   - joined results of all instances
    def run
      results = []
      InputReader.get_instances.each { |instance|
        results << CoveringSolver.solve(instance)
      }
      puts results.join("\n\n")
    end
  end
end

