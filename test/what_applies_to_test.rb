require "test_helper"

class WhatAppliesToTest < Scope::TestCase
  context "with a simple world" do
    setup do
      @world = Statuesque::World.new
      @world.adj_subtype :red, :scarlet, :maroon, :fuchsia
      @world.adj_subtype :small, :tiny, :petite
      @world.adj_subtype :colored, :red, 
    end

    should "have scarlet count as red" do
      assert @world.what_applies_to(:scarlet).include?(:red), "Red isn't applied to scarlet!"
    end

    should "have scarlet count as colored" do
      assert_equal [:colored, :red, :scarlet], @world.what_applies_to(:scarlet)
    end
  end
end
