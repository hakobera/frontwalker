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

        config = distribution[:distribution_config]

        aliases = distribution[:aliases]
        p distribution

        return(<<-EOS)
distribution "#{name}" do
  id          "#{id}"
  price_class "#{config[:price_class]}"
  enabled     #{config[:enabled]}
  default_root_object "#{config[:default_root_object]}"
#{output_aliases(config[:aliases])}
#{output_origins(config[:origins])}
end
        EOS
      end

      def output_aliases(aliases)
        return "" unless aliases[:quantity] != 0
        return(<<-EOS)

  aliases(
    #{aliases[:items].map {|i| "\"#{i}\""}.join(",\n    ").chomp}
  )
        EOS
      end

      def output_origins(origins)
        return(<<-EOS)
  origins do
#{origins[:items].map {|i| output_origin(i)}.join("\n").chomp}
  end
        EOS
      end

      def output_origin(origin)
        return(<<-EOS)
    origin "#{origin[:id]}" do
      domain_name "#{origin[:domain_name]}"
#{output_origin_config(origin[:s3_origin_config], origin[:custom_origin_config]).chomp}      
    end
        EOS
      end

      def output_origin_config(s3_config, custom_config)
        if s3_config
          return(<<-EOS)
      origin_access_identity "#{s3_config[:origin_access_identity]}"
          EOS
        else
          return(<<-EOS)
      http_port  #{custom_config[:http_port]}
      https_port #{custom_config[:https_port]}
      origin_protocol_policy "#{custom_config[:origin_protocol_policy]}"
          EOS
        end
      end
    end
  end
end
