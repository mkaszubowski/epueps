require "ckeditor/orm/active_record"


class Ckeditor::Asset < ActiveRecord::Base
  include ActiveRecord
  include Ckeditor::Orm::ActiveRecord::AssetBase

  delegate :url, :current_path, :content_type, :to => :data

  validates_presence_of :data
end
