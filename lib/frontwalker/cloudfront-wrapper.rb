require 'frontwalker/cloudfront-exporter'

module Frontwalker
  class CloudFrontWrapper

    def initialize(options)
      @options = options
    end

    def export
      Exporter.export(@options)
    end
  end
end
