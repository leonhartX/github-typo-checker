module Typochecker
  class Generator
    class << self
      def create(path="dict")
        file = File.open(path)
        dict = {}
        file.each do |line|
          typo,orig = line.chomp.split ":"
          next if orig.size < 6 || typo[0] != orig[0] || typo[typo.size-1] != orig[orig.size-1]
          distance = distance typo, orig
          dict[typo] = orig if distance < 2
        end
        dict
      end

      # private
      def distance(src, dist)
        m = src.size
        n = dist.size
        d = Array.new(m + 1) { Array.new(n + 1) { 0 } }
        0.upto(m) { |i| d[i][0] = i }
        0.upto(n) { |i| d[0][i] = i }
        1.upto(m) do |i|
          1.upto(n) do |j|
            cost = src[i-1] == dist[j-1] ? 0 : 1
            d[i][j] = [d[i-1][j] + 1, d[i][j-1] + 1, d[i-1][j-1] + cost].min
          end
        end
        d[m][n]
      end

      def charset(str)
      	
      end
    end
  end
end
