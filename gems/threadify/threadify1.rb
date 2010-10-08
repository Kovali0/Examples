#!/usr/bin/env ruby
require 'rubygems'
require 'threadify'
require 'net/http'
require 'uri'

links = %w{
  http://ruby.about.com/
  http://stackoverflow.com/questions/tagged/ruby
  http://www.reddit.com/r/ruby/
  http://google.com/rubyisawesome
  http://www.ruby-lang.org/en/
  http://ruby-doc.org/
  http://watir.com/
  http://en.wikipedia.org/wiki/Ruby_%28programming_language%29
}

bad_links = links.threadify(5) do|link|
  res = Net::HTTP.get_response( URI.parse(link) )
  
  if res.is_a? Net::HTTPSuccess
    [ link, :good ]
  else
    [ link, :bad ]
  end
end.select{|link| link[1] == :bad }

puts bad_links
