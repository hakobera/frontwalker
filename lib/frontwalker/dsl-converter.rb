module Frontwalker
  class DSL
    class Converter
      class << self
        def convert(exported)
          self.new(exported).convert
        end
      end

      def initialize(exported)
        @distributions = exported[:distributions]
      end

      def convert
        @distributions.map {|i| output_distribution(i) }.join("\n")
      end

      private

      def output_distribution(distribution)
        id = distribution[:id]
        name = id # TODO

        aliases = distribution[:aliases]

        return(<<-EOS)
distribution "#{name}" do
  id          "#{id}"
  price_class "#{distribution[:price_class]}"
  enabled     #{distribution[:enabled]}
#{output_aliases(aliases)}
end
        EOS
      end

      def output_aliases(aliases)
        return "" unless aliases[:quantity] != 0
        return(<<-EOS)

  aliases(
    #{aliases[:items].map {|i| "\"#{i}\""}.join(",\n    ")}
  )
        EOS
      end
    end
  end
end
