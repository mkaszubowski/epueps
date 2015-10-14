class SubjectSerializer < ActiveModel::Serializer
  attributes :id, :slug, :name, :description, :image_url

  private

  def image_url
    ActionController::Base.helpers.asset_path(object.image.url)
  end
end
