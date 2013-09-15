# EmberExcerpt

Extracts keywords like methods, classes, etc from ember documentation. This is 
useful for creating syntax files for vim and other editors.

## Installation

Add this line to your application's Gemfile:

    $ gem 'ember-excerpt'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install ember-excerpt

## Usage

Default uses api.yml from ember's github repository.

    $ ember-excerpt -t <extract_type> -o <output_file>

Or specify a path to the yml file manually with -i

    $ ember-excerpt -i <doc.yml> -t <extract_type> -o <output_file>

