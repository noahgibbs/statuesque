module Statuesque
  class Base
    attr_accessor :name, :adjectives, :objects, :world, :noun, :extra_notability

    def to_s
      ((@adjectives || []) + [@noun || @name]).join(" ")
    end

    def notability
      raise "No world set!" unless @world

      (@adjectives || []).map do |adj|
        @world.notability_of_adjective(adj)
      end.sum + 0.1 + @extra_notability
    end
  end
end
