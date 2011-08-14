module Statuesque
  class Description
    attr_reader :object_buckets, :world, :sub_descriptions, :detail_level, :description

    def initialize(object_buckets, detail_level)
      @object_buckets = object_buckets || []
      @detail_level = detail_level
      @objects = @object_buckets.values.sum([])

      if @objects.empty? || (detail_level.is_a?(Numeric) && detail_level < 0.1)
        @object_buckets = []
        return
      end

      @world = objects[0].world
      @sub_descriptions = {}

      @adjs_in_common = @objects.map(&:adjectives).inject do |common_adjs, adjs|
        common_adjs | (adjs || [])
      end
    end

    def to_s
      render_description
    end

    def interest
      render_description
      @interest
    end

    private

    def divide_into_sub_descriptions
      return if @already_divided

      all_adjectives = objects.map(:adjectives).sum([]).uniq

      # First, find interesting divisions of the objects
      divs = @world.find_interesting_adjective_divisions_for (all_adjectives - @adjs_in_common)
      if divs.empty?
        # There are no remaining interesting ways to dice the objects.
        $stderr.puts "Alas!  Boredom reigns supreme!"
        return
      end

      # Then, try various possible divisions
      buckets_by_div = {}
      divs.each do |adjs_to_divide_on|
        buckets_by_div[adjs_to_divide_on] =
          objects_into_adjective_buckets(objects, adjs_to_divide_on)
      end

      # Make new sub-descriptions
      buckets_by_div.keys.each do |adjs|
        sub_desc = Description.new(buckets_by_div[adjs], detail_level - 1.0)
        @sub_descriptions[adjs] = sub_desc
        sub_desc.interest # Calculate how interesting
        $stderr.puts "New sub-description with interest level #{sub_desc.interest}"
      end

      # Then, figure out which subdivision(s) are interesting enough to keep

      @already_divided = true
    end

    def render_description
      return @description if @description

      if @objects.empty?
        @description = "(nothing)"
        @interest = 0.0
      elsif @detail_level.is_a?(Numeric) && @detail_level < 0.0
        @description = "(nothing)"
        @interest = 0.0
      elsif @detail_level.is_a?(Numeric) && @objects.size <= @detail_level
        @description = @objects.map(&:to_s).join(" and ")
        @interest = @objects.map(&:notability).sum
      elsif @detail_level.is_a?(Numeric) && @detail_level <= 1.0
        @description = "some #{@adjs_in_common.join(" ")} objects"
        @interest = 0.1 + @adjs_in_common.map {|adj| @world.notability_of_adjective(adj)}.sum
      else
        divide_into_sub_descriptions
        @description = "(unimplemented)"
        @interest = 100
      end

      @description
    end

    def objects_into_adjective_buckets(objects, adjectives)
      buckets = {}
      adjectives.each {|adj| buckets[adj] = []}
      objects.each do |object|
        object_adjs = object.adjectives
        adjectives.each do |bucket_adj|
          buckets[bucket_adj] << object if object_adjs.include?(bucket_adj)
        end
      end

      buckets
    end
  end
end
