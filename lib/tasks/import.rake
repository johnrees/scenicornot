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

  task thumbnails: :environment do
    Scene.where(data: {}).order(average_int: :desc).each do |scene|
      begin
        scene.update_attribute(:data, scene.raw_data)
        p scene.id
        sleep(rand(5))
      rescue
        p "no #{scene.id}"
      end
    end
  end
end