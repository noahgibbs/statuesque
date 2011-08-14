module Statuesque
  class World
    attr_reader :objects

    def initialize
      @objects = []

      @adj_one_of = []
      #@adj_one_of << [:large, :small]
      @adj_subtypes = {}
      #@adj_subtypes[:red] = [:maroon, :scarlet]
      @adj_synonyms = []
      #@adj_synonyms << [:large, :big]
      @adj_notability = {}
      #@adj_notability[:plumed] = 1.0
    end

    def adj_subtype(main_adj, *adjs)
      adjs = adjs.flatten
      @adj_subtypes[main_adj] = adjs
    end

    def adj_one_of(*adjs)
      adjs = adjs.flatten
      @adj_one_of << adjs
    end

    def adj_synonyms(*adjs)
      adjs = adjs.flatten
      @adj_synonyms << adjs
    end

    def adj_notable(adj, amount = 1.0)
      @adj_notability[adj] = amount
    end

    # This takes a set of adjectives and adds all
    # other applicable ones.  For instance,
    # what_applies_to("tiny", "maroon") might return
    # ["tiny", "small", "petite", "maroon", "red", "colored"]
    # TODO: cache me by adjective and combine?
    def what_applies_to(*adjectives)
      adjectives = adjectives.flatten

      @adj_synonyms.each do |syns|
        adjectives += syns unless (adjectives & syns).empty?
      end

      last_adjectives = adjectives.uniq.sort
      loop do
        @adj_subtypes.keys.each do |subtype|
          adjectives += [subtype] unless (@adj_subtypes[subtype] & adjectives).empty?
        end

        adjectives = adjectives.uniq.sort
        break adjectives if adjectives == last_adjectives
        last_adjectives = adjectives
      end

      @adj_synonyms.each do |syns|
        adjectives += syns unless (adjectives & syns).empty?
      end
      adjectives = adjectives.uniq.sort

      adjectives
    end

    def interesting_adjective_divisions_for(*adjectives)
      adjectives = what_applies_to(adjectives.flatten)
      divisions = []
      @adj_one_of.each do |adjs|
        divisions << adjs unless (adjectives & adjs).empty?
      end

      divisions
    end

    def notability_of_adjective(adj)
      @adj_notability[adj] || 0.5
    end
  end
end
