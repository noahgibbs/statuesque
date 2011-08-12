module Statuesque
  module DSL
    def self.current_world
      @world ||= Statuesque::World.new
    end

    def self.new_world
      @world = Statuesque::World.new
    end

    def object(name = nil, &block)
      ob = Statuesque::Base.new
      world = Statuesque::DSL.current_world
      world[:objects] ||= []
      world[:objects] << ob

      ob.name = "StatuesqueObject#{ob.object_id}" unless name
      ob.name = name if name
      ob.instance_eval(&block)
    end

    def adjectives(&block)
      AdjectiveSetDSL.instance_eval(&block)
    end

    class AdjectiveSetDSL
      def self.one_of(adjectives)
      end
    end
  end
end
