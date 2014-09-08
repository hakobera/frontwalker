module Frontwalker
  class Exporter

    class << self
      def export(options)
        self.new(options).export
      end
    end

    def initialize(options)
      @options = options
      @client = @options.cloudfront.client
    end

    def export
      result = {}
      distibutions = result[:distributions] = []
      export_distributions(distibutions)
      return result
    end

    private

    def export_distributions(distibutions)
      ids = []
      resp = @client.list_distributions
      resp[:items].each do |distibution|
        ids << distibution[:id]
      end

      ids.each do |id|
        distibutions << @client.get_distribution(id: id)
      end
    end
  end
end
