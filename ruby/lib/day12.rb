require 'rgl/adjacency'

module Day12
  # FP = '../input_files/test.day12.txt'
  FILE_PATH = '../input_files/input.day12.txt'
  LINES = File.readlines(FILE_PATH).map { |x| x.chomp("\n") }

  def self.parse_input
    LINES
      .map { |line| line.split('-') }
  end

  class Solver
    attr_accessor :path_count, :adj

    def initialize
      @path_count = 0
      @adj = RGL::AdjacencyGraph.new
      Day12.parse_input.each { |edge| adj.add_edge(edge[0], edge[1]) }
    end

    def small_cave?(c)
      c.downcase == c
    end

    def find_paths(path_so_far, visited_twice = true)
      u = path_so_far[-1]

      adj.adjacent_vertices(u).each do |v|
        if v == 'end'
          @path_count += 1
          next
        elsif v == 'start' || v == u
          next
        elsif small_cave?(v) && path_so_far.include?(v)
          next if visited_twice
          find_paths(path_so_far + [v], true)
        else
          find_paths(path_so_far + [v], visited_twice)
        end
      end
    end
  end

  class Part1 < Solver
    def solve
      find_paths(['start'])

      @path_count
    end
  end

  class Part2 < Solver
    def solve
      find_paths(['start'], false)

      @path_count
    end
  end
end


