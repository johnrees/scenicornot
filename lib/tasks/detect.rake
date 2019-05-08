require "google/cloud/vision"

namespace :detect do
  task features: :environment do
    image_annotator = Google::Cloud::Vision::ImageAnnotator.new

    Parallel.each(Scene.where(labels_data: nil)) do |scene|
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
