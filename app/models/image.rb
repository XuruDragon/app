class Image < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  belongs_to :gallery, polymorphic: true

  mount_uploader :name, ImageUploader

  def to_jq_upload
    {
      "name" => read_attribute(:name),
      "size" => name.size,
      "url" => name.url,
      "thumbnailUrl" => name.small.url,
      "deleteUrl" => backend_image_path(id: id),
      "deleteType" => "DELETE"
    }
  end

  def self.in_gallery
    where("gallery_id IS NOT ?", nil)
  end

  def self.enabled
    where enabled: true
  end
end