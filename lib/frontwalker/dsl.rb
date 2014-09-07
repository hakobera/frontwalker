require 'frontwalker/dsl-converter'

require 'ostruct'
require 'uri'

module Frontwalker
  class DSL

    class << self
      def convert(distibutions)
        Converter.convert(distibutions)
      end
    end

    attr_reader :result

    def initialize(path, &block)
      
    end
  end
end
