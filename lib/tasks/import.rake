require 'csv'

namespace :import do
  task tsv: :environment do
    CSV.foreach("votes.tsv", { :headers => true, :col_sep => "\t" }) do |row|
      Scene.find_or_initialize_by(id: row['ID']).tap do |scene|
        scene.latitude = row["Lat"]
        scene.longitude = row["Lon"]
        scene.average_int = BigDecimal.new(row["Average"]) * 10000
        scene.variance_int = BigDecimal.new(row["Variance"]) * 10000
        votes = row["Votes"].split(",").map(&:to_i)
        scene.votes = votes
        scene.num_votes = votes.length
        scene.geograph_uri = row["Geograph URI"]
        scene.save
      end
    end
  end
end