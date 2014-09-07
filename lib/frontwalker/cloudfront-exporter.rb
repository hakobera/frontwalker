module Frontwalker
  class Exporter

    class << self
      def export(options)
        self.new(options).export
      end
    end

    def initialize(options)
      @options = options
    end

    def export
      result = {}
      distibutions = result[:distributions] = []
      export_distributions(distibutions)
      return result
    end

    private

    def export_distributions(distibutions)
      resp = @options.cloudfront.client.list_distributions
      resp[:items].each do |distibution|
        distibutions << distibution
      end
    end
  end
end
