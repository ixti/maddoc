# stdlib
require 'ostruct'
require 'optparse'


# 3rd-party
require 'slim'
require 'sprockets'
require 'redcarpet'
require 'pygments'


module MadDoc
  class Runner
    attr_reader :title

    def initialize argv
      parse!(argv).tap do |options|
        @title = options.title
      end

      @source = ARGF.read unless argv.empty? and $stdin.tty?
    end


    def asset pathname
      environment[pathname].to_s
    end


    def environment
      @environment ||= Sprockets::Environment.new(MadDoc.root.join('templates')).tap do |env|
        env.append_path 'assets/stylesheets'
        env.css_compressor = :sass
      end
    end


    def body
      renderer = Class.new(Redcarpet::Render::SmartyHTML) do
        def block_code(code, lang)
          lang = lang && lang.split.first || "text"

          add_code_tags(
            Pygments.highlight(code, {
              :lexer => lang,
              :options => { :encoding => 'utf-8' }
            }),
            lang
          )
        end

        def add_code_tags(code, lang)
          code = code.sub(/<pre>/,'<pre><code class="' + lang + '">')
          code = code.sub(/<\/pre>/,"</code></pre>")
        end
      end.new({
        :with_toc_data      => true
      })

      Redcarpet::Markdown.new(renderer, {
        :no_intra_emphasis  => true,
        :tables             => true,
        :fenced_code_blocks => true,
        :autolink           => true,
        :strikethrough      => true,
        :lax_spacing        => true
      }).render(@source)
    end


    def parse! argv
      options = OpenStruct.new({
        :title => 'Untitled mad documentation'
      })

      OptionParser.new do |opts|
        opts.on('-t', '--title [TITLE]', 'Title') do |title|
          options.title = title.strip
        end
      end.parse! argv

      options
    end


    def template
      Slim::Template.new MadDoc.root.join('templates', 'layout.slim').to_s
    end


    def run!
      puts template.render(self)
    end


    def self.run argv
      new(argv).run!
    end
  end
end
