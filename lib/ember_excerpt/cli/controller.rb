module EmberExcerpt
  module CLI

    require 'ember_excerpt/version'
    require 'uri'
    require 'yaml'
    require 'open-uri'

    class Controller

      def initialize(options)
        @options = options
      end

      def show_version
        puts VERSION
      end

      def show_help
        puts @options.options
      end

      def show_error(msg = @options.error)
        puts "Error: #{msg}"
        puts

        show_help
      end

      def show_invalid_option
        show_error @options.error
      end

      def show_missing_args
        show_error @options.error
      end

      def show_parser_error
        show_error @options.error
      end

      def extract
        begin
          data = load(@options.input)

          extractor = get_extractor(@options.type)
          items = extractor.extract(data)

          write_output(items)
        rescue => err
          puts 'Extract Failed'
          if @options.verbose
            puts err.backtrace
          end
        end
      end

      def write_output(items)
        if items.length == 0
          puts "Nothing to output for #{options.type}"
        else
          file = File.open(@options.output, 'w')
          items.each do |item|
            file.puts item
          end

          file.close
          puts "Wrote #{items.length} items to #{@options.output}"
        end
      end

      def get_extractor(type)
        if type == 'class'
          return ClassExtractor.new
        elsif type == 'method'
          return MethodExtractor.new
        else
          raise "Extractor not found for type: #{type}"
        end
      end

      def uri?(string)
        uri = URI.parse(string)
        %w( http https ).include?(uri.scheme)
      rescue URI::BadURIError
        false
      rescue URI::InvalidURIError
        false
      end

      def load(input)
        puts "Loading #{input}"
        data = open(input)
        yml = YAML.load(data)

        return yml
      end
    end

    class MethodExtractor
      def extract(yml)
        methods = []
        unless yml['classitems'].nil?
          yml['classitems'].each do |key, value|
            access = key['access']
            if (!key['name'].nil?) && (access == 'public' || access.nil?)
              methods << key['name']
            end
          end
        end

        methods
      end
    end

    class ClassExtractor
      def extract(yml)
        classes = []
        unless yml['classes'].nil?
          yml['classes'].each do |key, value|
            unless value['name'].nil?
              classes << value['name']
            end
          end
        end

        classes
      end
    end
  end
end
