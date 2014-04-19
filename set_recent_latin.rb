#!/usr/bin/env ruby

require './flickr'

if __FILE__ == $0
  flickr = Flickr.new("oauthtokens.yml")
  list = flickr.recent((ARGV[0] || 1).to_i)
  photosets = {}
  list.each do |photo|
    if photo.scientific_name
      puts "Skipping: #{photo.original_file} (#{photo.title}) [#{photo.scientific_name}]"
      next
    end
    set = photo.sets.first
    if !set.scientific_name
      puts "MISSING!!! #{set.title} does not contain scientific name: #{set.description}"
      next
    end
    puts "Adding #{set.scientific_name} to #{photo.original_file} (#{photo.title})"
    photo.add_tags([set.scientific_name])
    photo.description = "Scientific name: #{set.scientific_name}\n"+photo.description
    set = photo.sets.first
    photosets[set.id] = set
  end

  photosets.keys.each do |set_id|
    set = photosets[set_id]
    puts "Reordering: #{set.title}"
    set.reorder
  end
end
