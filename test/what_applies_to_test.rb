require "test_helper"

class WhatAppliesToTest < Scope::TestCase
  context "with a simple world" do
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

    should "have scarlet count as red" do
      assert @world.what_applies_to(:scarlet).include?(:red), "Red isn't applied to scarlet!"
    end

    should "have scarlet count as colored" do
      assert_equal [:colored, :red, :scarlet], @world.what_applies_to(:scarlet)
    end

    should "have enormous count as big" do
      assert @world.what_applies_to(:enormous).include?(:big), "Enormous doesn't count as big!"
    end
  end
end
