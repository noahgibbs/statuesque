require "test_helper"

class SimpleDescriptionTest < Scope::TestCase
  context "A simple world" do
    setup do
      @world = Statuesque::World.new
      @world.adj_subtype :red, :scarlet, :maroon, :fuchsia
      @world.adj_subtype :small, :tiny
      @world.adj_subtype :colored, :red, :green
      @world.adj_synonyms :small, :little, :petite
      @world.adj_synonyms :large, :big
      @world.adj_synonyms :huge, :enormous, :gigantic
      @world.adj_subtype :large, :gigantic
    end

    context "with a stuffed wombat" do
      setup do
        @wombat = Statuesque::Base.new
        @wombat.world = @world
        @wombat.noun = "wombat"
        @wombat.adjectives = ["stuffed", "dusty"]
      end

      should "have a good basic description" do
        @desc = Statuesque::Description.new([@wombat], 7.0)
        assert_equal "stuffed dusty wombat", @desc.to_s
      end
    end

  end
end
