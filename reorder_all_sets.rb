#!/usr/bin/env ruby

require './flickr'

if __FILE__ == $0
  flickr = Flickr.new("oauthtokens.yml")
  flickr.photosets.each do |photoset|
    photoset.reorder
  end
end
