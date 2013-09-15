module EmberExcerpt
  module CLI

    require 'optparse'
    require 'ostruct'

    class Options
      include Loader

      def load(args)
        opts = OpenStruct.new
        opts.action = :extract
        opts.input = nil

        parser = OptionParser.new do |o|
          opts.options = o

          o.banner = "Usage: ember-excerpt -t <type> -o <output>"
          o.separator ''
          o.separator 'Options:'
          o.separator ''

          o.on_head('-t', '--type <type>', 'Specify the type to extract') do |type|
            opts.type = type
          end

          o.on_head('-o', '--output <output>', 'Specify the output file to extract into') do |output|
            opts.output = output
          end

          o.on_tail('-i', '--input <input>', 'Optional specify the input yaml file to extract from, default(github)') do |input|
            opts.input = input
          end

          o.on('-v', '--verbose', 'Display verbose output') do
            opts.verbose = true
          end
          
          o.on('-D', '--debug', 'Display debug output') do
            opts.verbose = true
            opts.debug = true
          end

          o.on_tail('-V', '--version', 'Print version') do
            opts.action = :show_version
          end

          o.on_tail('-h', '--help', 'Print help') do
            opts.action = :show_help
          end
        end

        begin
          parser.parse!(args)

          raise OptionParser::MissingArgument.new('type') if opts.type.nil?
          raise OptionParser::MissingArgument.new('output') if opts.output.nil?

          if opts.input.nil?
            opts.input = 'https://raw.github.com/emberjs/website/master/data/api.yml'
          end
          
        rescue OptionParser::InvalidOption => e
          opts.error = e
          opts.action = :show_invalid_option
        rescue OptionParser::MissingArgument => e
          opts.error = e
          opts.action = :show_missing_args
        rescue OptionParser::ParseError => e
          opts.error = e
          opts.action = :show_parser_error
        end

        opts
      end
    end
  end
end
