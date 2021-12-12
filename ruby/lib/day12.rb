require 'rgl/adjacency'

module Day12
  # FP = '../input_files/test.day12.txt'
  FP = '../input_files/input.day12.txt'
  LINES = File.readlines(FP).map { |x| x.chomp!("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('-') }
  end

  class Part1
    attr_accessor :path_count, :adj #, :is_visited

    def initialize
      @path_count = 0
      @adj = RGL::AdjacencyGraph.new
      Day12.parse_input.each { |edge| adj.add_edge(edge[0], edge[1]) }

      # @is_visited = {}
    end

    def solve
      # TODO(gianluca): Remove when done
      # puts("Useful methods for adj: #{adj}:
      #   1. has_edge(start-c): #{adj.has_edge?('start', 'c')},
      #      has_edge(start-A): #{adj.has_edge?('start', 'A')},
      #   2. adj.adjacent_vertices('start'): #{adj.adjacent_vertices('start')}")

      # @adj.each_vertex { |u| @is_visited[u] = false }

      find_paths(['start'], 0)

      @path_count
    end

    def small_cave?(c)
      c.downcase == c
    end

    def find_paths(path_so_far, counter)
      u = path_so_far[-1]
      # puts("\npath_so_far: #{path_so_far}, want to add: #{adj.adjacent_vertices(u)}")

      # return if counter >= 6

      adj.adjacent_vertices(u).each do |v|
        # puts "considering to add #{v} to #{path_so_far}"
        if v == 'end'
          # puts "FOUND PATH: #{(path_so_far + [v]).join('-')}"
          @path_count += 1
          next
        elsif small_cave?(v) && path_so_far.include?(v)
          # puts "discarded: small cave #{v} already in the path"
          next
        elsif v == 'start'
          # puts "discarded: 'start'"
          next
        elsif v == u
          # don't re-add the same
          # puts "discarded: same as last added"
          next
        else
          find_paths(path_so_far + [v], counter + 1)
        end
      end
    end
  end

  class Part2
    attr_accessor :path_count, :adj

    def initialize
      @path_count = 0
      @adj = RGL::AdjacencyGraph.new
      Day12.parse_input.each { |edge| adj.add_edge(edge[0], edge[1]) }
    end

    def solve
      # TODO(gianluca): Remove when done
      # puts("Useful methods for adj: #{adj}:
      #   1. has_edge(start-c): #{adj.has_edge?('start', 'c')},
      #      has_edge(start-A): #{adj.has_edge?('start', 'A')},
      #   2. adj.adjacent_vertices('start'): #{adj.adjacent_vertices('start')}")

      # @adj.each_vertex { |u| @is_visited[u] = false }

      find_paths(['start'], false, 0)

      @path_count
    end

    def small_cave?(c)
      c.downcase == c
    end

    def find_paths(path_so_far, visited_twice, counter)
      u = path_so_far[-1]
      # puts("\npath_so_far: #{path_so_far}, want to add: #{adj.adjacent_vertices(u)}")

      # return if counter >= 6

      adj.adjacent_vertices(u).each do |v|
        # puts "considering to add #{v} to #{path_so_far}"
        if v == 'end'
          # puts "FOUND PATH: #{(path_so_far + [v]).join('-')}"
          @path_count += 1
          next
        elsif v == 'start'
          # puts "discarded: 'start'"
          next
        elsif v == u
          # don't re-add the same
          # puts "discarded: same as last added"
          next
        elsif small_cave?(v) && path_so_far.include?(v) && visited_twice
          next
        elsif small_cave?(v) && path_so_far.include?(v) && !visited_twice
          find_paths(path_so_far + [v], true, counter + 1)
        else
          find_paths(path_so_far + [v], visited_twice, counter + 1)
        end
      end
    end
  end
end

# puts Day12::Part1.new.solve
puts Day12::Part2.new.solve


