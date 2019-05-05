require "google/cloud/vision"

namespace :detect do
  task features: :environment do
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    Scene.where(labels_data: nil).each do |scene|
      begin
        response = image_annotator.label_detection image: scene.data['url']
        scene.update_attribute(:labels_data, response.responses.to_json)
        p scene.id
      rescue
        p "ERROR FOR #{scene.id}"
      end
    end
  end
end
