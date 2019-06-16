require "csv"
require 'json'
require 'open-uri'

namespace :export do
  task local_authorities: :environment do
    Scene.where.not(lad17nm: nil).pluck(:lad17nm).uniq.each do |la|
      system "mkdir -p \"out/#{la}\""
      CSV.open("out/#{la}/_#{la}.csv", "wb") do |csv|
        csv << ["average", "num_votes", "variance", "url", "id"]
        Scene.where('labels_data::text ILIKE ?', '%building%').where(lad17nm: la).each do |scene|

          if scene.data['url']
            arr = [
              scene.average_int/10000.0,
              scene.num_votes,
              scene.variance_int/10000.0,
              scene.data['url'],
              scene.geograph_uri.split("/").last,
            ]
            csv << arr

            command = "wget -O \"out/#{la}/#{[
              scene.average_int,
              scene.num_votes,
              scene.variance_int,
              scene.geograph_uri.split("/").last
            ].join('-')}.jpg\" #{scene.data['url']} --quiet"

            system command
          end

        end
      end
    end
  end
end
