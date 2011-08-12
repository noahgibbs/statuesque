module Statuesque
  class World
    attr_reader :objects

    def initialize
      @objects = []

      @adj_one_of = []
      #@adj_one_of << [:large, :small]
      @adj_subtypes = {}
      #@adj_subtypes[:red] = [:maroon, :scarlet]
    end

    def adj_subtype(main_adj, *adjs)
      adjs = adjs.flatten
      @adj_subtypes[main_adj] = adjs
    end

    def adj_one_of(*adjs)
      adjs = adjs.flatten
      @adj_one_of << adjs
    end

    # This takes a set of adjectives and adds all
    # other applicable ones.  For instance,
    # what_applies_to("tiny", "maroon") might return
    # ["tiny", "small", "petite", "maroon", "red", "colored"]
    # TODO: cache me by adjective and combine?
    def what_applies_to(*adjectives)
      adjectives = adjectives.flatten

      last_adjectives = adjectives.uniq.sort
      loop do
        @adj_subtypes.keys.each do |subtype|
          adjectives += [subtype] unless (@adj_subtypes[subtype] & adjectives).empty?
        end

        adjectives = adjectives.uniq.sort
        return adjectives if adjectives == last_adjectives
        last_adjectives = adjectives
      end
    end

    def interesting_adjective_divisions(adjectives)
      adjectives = what_applies_to(adjectives)
      divisions = []
      @adj_one_of.each do |adjs|
        divisions << adjs unless (adjectives & adjs).empty?
      end
    end
  end
end
