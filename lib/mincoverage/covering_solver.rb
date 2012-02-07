module MinCoverage

  # Defines class for solving covering of segment <tt><0,m></tt> with subsegments of Segment type.
  class CoveringSolver
    class << self

      # This method solves covering of Instance which includes subsegment's list
      # _segment_list_ and right segment's coordinate _m_.
      # ---
      # Complexity:: <tt>c = N + 2N log N + N = 2(N + N log N)</tt>,
      #              where +N+ stands for number of subsegments in instance
      # * Args::
      #   - _instance_ instance to solve
      # * Returns::
      #   - a string with result
      #   - result's format:
      #       2       .. number of subsegments which covers whole segment
      #       -2 1    .. subsegment 1
      #       1 5     .. subsegment 2
      def solve(instance)
        segs = instance.segment_list
        m = instance.m
        
        remove_useless_items!(segs, m)       
        sort_items!(segs)
        return [0] if segs.empty?

        result = []
        left_boundary = 0   # pick 0 as a first left_boundary
        candidate = segs[0]  # pick first subsegment as a first candidate for solution
        hole_indicator = true # indicates if segment contains hole, then no result
        
        i = 0
        while i < segs.size do
          if(segs[i].left <= left_boundary)
            if(segs[i].right >= candidate.right)
              candidate = segs[i]
              result << candidate if (i == segs.size-1) # add candidate to result if it is last item
            end
            hole_indicator = true
          else
            result << candidate # save candidate to results
            break if candidate.right >= m # break if whole segment covered

            left_boundary = candidate.right # new left boundary set to stored segment's right coordinate
            i -= 1

            if hole_indicator
              hole_indicator = false
            else
              return [0]  # return 0 if there is a hole in subsegments
            end
          end
          i += 1
        end

        return [0] if(result.first.left > 0 || result.last.right < m) # return 0 if not covers whole segment
        return ([result.size] + result).join("\n")  # add number of subsegments as a first item of array and return
      end

      # Removes useless subsegments from _segments_ which cannot cover whole segment - those who have:
      # * left coordinate > right .. <tt><5,2></tt>
      # * both coordinates less than <tt>0</tt> .. <tt><-1,0>, <-3,-1></tt>
      # * both coordinates higher than <tt>m</tt> .. <tt>m=10, <10,11>, <12,15></tt>
      # ---
      # * Args::
      #   - _segments_ subsegment list
      #   - _m_ right coordinate of segment we want to cover
      def remove_useless_items!(segments, m)
        segments.select! { |i|
          not (i.left >= i.right) || ((i.left < 1) and (i.right < 1)) || ((i.left >= m) and (i.right >= m))
        }
      end

      # Sorts array of _segments_ by its _left_ coordinate at first and then by segment's _size_.
      # ---
      # * Args::
      #   - _segments_ subsegment list
      def sort_items!(segments)
        segments.sort_by! { |i|
          [ i.left, i.size ]
        }
      end
    end
  end
end
