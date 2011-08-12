require "test_helper"

class InterestingAdjectivesTest < Scope::TestCase
  context "with a simple world" do
    setup do
      @world = Statuesque::World.new
      @world.adj_one_of :small, :large
      @world.adj_one_of :red, :green, :yellow, :brown
      @world.adj_subtype :brown, :chocolate
      @world.adj_subtype :large, :huge, :gigantic
    end

    should "find sizes interesting" do
      assert_equal [[:small, :large]], @world.interesting_adjective_divisions_for(:small)
    end

    should "find applicable adjectives interesting" do
      assert_equal [[:red, :green, :yellow, :brown]], @world.interesting_adjective_divisions_for(:chocolate)
    end

    should "find applicable adjectives interesting" do
      assert_equal [[:small, :large], [:red, :green, :yellow, :brown]],
         @world.interesting_adjective_divisions_for(:chocolate, :gigantic)
    end

  end
end
