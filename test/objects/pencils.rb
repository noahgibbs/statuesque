require "statuesque/dsl"
include Statuesque::DSL

adjectives do
  one_of :large, :small, :tiny
  one_of :red, :green, :maroon
  subtype :red, :maroon, :fuchsia, :scarlet
  subtype :small, :tiny

  noteworthy :fancy, :plumed, :smelly
end

object do
  adjectives = [:large, :green, :gnawed]
end

object do
  adjectives = [:large, :green, :knobby, :smelly]
end

object do
  adjectives = [:large, :green, :gnarled]
end

object do
  adjectives = [:large, :green, :gnarly, :smelly]
end

object do
  adjectives = [:small, :red, :gnawed]
end

object do
  adjectives = [:small, :red, :smelly]
end

object do
  adjectives = [:small, :maroon]
end

object do
  adjectives = [:small, :red, :neat]
end

object do
  adjectives = [:small, :red, :pinched]
end

object do
  adjectives = [:small, :red]
end

object do
  adjectives = [:tiny, :fuchsia, :fancy, :plumed]
end
