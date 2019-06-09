require 'json'
require 'open-uri'

namespace :scrape do
  task local_authorities: :environment do
    Parallel.each(Scene.where(lad17cd: nil)) do |scene|
      begin
        url = "https://ons-inspire.esriuk.com/arcgis/rest/services/Administrative_Boundaries/Local_Authority_Districts_December_2017_Boundaries/MapServer/1/query?where=1%3D1&outFields=lad17cd,lad17nm&geometry=#{scene.longitude.to_f}%2C#{scene.latitude.to_f}&geometryType=esriGeometryPoint&inSR=4326&spatialRel=esriSpatialRelIntersects&returnGeometry=false&outSR=4326&f=json"
        data = JSON.parse(open(url).read)
        s = data['features'][0]['attributes']
        scene.update_attributes(lad17cd: s["lad17cd"], lad17nm: s["lad17nm"])
        sleep(rand(0.8))
        p scene.id, s
      rescue StandardError => e
        p "ERROR FOR #{scene.id}, #{e.message}, #{scene.latitude}, #{scene.longitude}"
      end
    end
    Scene.connection.reconnect!
  end
end
