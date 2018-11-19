# frozen_string_literal: true

require 'open-uri'
require 'json'

class Scene < ApplicationRecord
  def average
    average_int / 10_000.0000
  end

  def variance
    variance_int / 10_000.0000
  end

  def img_url
    data['thumbnail_url'] || ''
  end

  def raw_data
    url = "http://api.geograph.org.uk/api/oembed?url=#{CGI.escape(geograph_uri)}&format=json"
    JSON.parse(open(url).read)
    # CGI::unescape(json['thumbnail_url'])
  end
end
