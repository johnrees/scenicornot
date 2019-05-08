require "google/cloud/vision"

namespace :detect do
  task features: :environment do

    Parallel.each(Scene.where(labels_data: nil)) do |scene|
      begin
        image_annotator = Google::Cloud::Vision::ImageAnnotator.new
        response = image_annotator.label_detection image: scene.data['url']
        scene.update_attribute(:labels_data, response.responses.to_json)
        p scene.id
      rescue StandardError => e
        p "ERROR FOR #{scene.id}, #{e.message}"
      end
    end
    Scene.connection.reconnect!

  end
end
