#!/usr/bin/env ruby

def supported_locales
  @supported_locales ||= begin
    open('../../shared-configuration-bundle/Resources/config/sites.yml') do |f|
      f.grep(/^  99designs\./).map do |s|
        /^  99designs\.([A-Za-z_]+)/.match(s)[1].sub('_', '-')
      end.sort
    end
  end
end

def locales_in_intl
  @locales_in_intl ||= Dir.glob('../locale-data/json/*.json').map do |n|
    /^\.\.\/locale-data\/json\/([^.]+)\.json$/.match(n)[1]
  end
end

def locales_to_delete
  locales_in_intl - supported_locales
end

locales_to_delete.each do |n|
  File.delete("../locale-data/json/#{n}.json")
  File.delete("../locale-data/jsonp/#{n}.js")
end
