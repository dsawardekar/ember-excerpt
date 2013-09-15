module EmberExcerpt
  module CLI

    require_relative 'options'
    require_relative 'router'

    class App
      def start(args)
        options = Options.new
        opts = options.load(args)

        router = Router.new
        router.route(opts.action, opts)
      end
    end
  end
end
