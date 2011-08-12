require "test_helper"

class WhatAppliesToTest < Scope::TestCase
  context "with a simple world" do
    setup_once do
      @world = Statuesque::World.new
      @world.adj_subtype :red, :scarlet, :maroon, :fuchsia
    end

    should "have scarlet count as red" do
      assert_equal [:red, :scarlet], @world.what_applies_to(:scarlet)
    end
  end
end
