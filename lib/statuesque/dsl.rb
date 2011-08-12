module Statuesque
  module DSL
    def object(&block)
      ob = Statuesque::Base.new
      ob.instance_eval(&block)
    end
  end
end
