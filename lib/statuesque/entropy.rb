module Statuesque
  module Entropy
    def self.entropy_by_count_and_total(count, total)
      p = count.to_f / total.to_f
      pnot = 1.0 - p
      -p * Math.log(p, 2.0) - pnot * Math.log(pnot, 2.0)
    end
  end
end
