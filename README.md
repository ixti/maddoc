# MadDoc

Simple Markdown to HTML converter. In comparison to standard, built-in CLI
util it generates a nice-looking little-bit styled HTML.


## Installation

    $ gem install maddoc


## Usage

    maddoc my-file.md > my-file.html

MadDoc was mainly written for very own personal purposes of "sending" a
nice-looking versions of documentation files written in MarkDown for my
colleagues. Once markdown is converted in a nice looking HTML, it's not
a problem to convert it to PDF if you would like to:

    for file in *.md ; do
      file = $(basename $file .md)
      maddoc $file.md > $file.html
      wkhtmltodpf $file.html $file.pdf
      rm $file.html
    done


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
