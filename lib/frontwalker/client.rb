require 'frontwalker/dsl'
require 'frontwalker/cloudfront-wrapper'

require 'logger'
require 'ostruct'
require 'aws-sdk'

module Frontwalker
  class Client

    def initialize(options = {})
      @options = OpenStruct.new(options)
      @options.logger ||= Logger.new($stdout)
      @options.cloudfront = AWS::CloudFront.new
      @cloudfront = CloudFrontWrapper.new(@options)
    end

    def export
      exported = AWS.memoize { @cloudfront.export }
      
      if block_given?
        yield(exported, DSL.method(:convert))
      else
        DSL.convert(exported)
      end
    end
  end
end
