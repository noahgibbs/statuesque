module Statuesque
  class Base
    attr_accessor :name, :adjectives, :objects
  end

  class AdjectiveSet
    TYPES = [:one_of, :subtype]
    attr_accessor :type, :adjectives
  end
end
