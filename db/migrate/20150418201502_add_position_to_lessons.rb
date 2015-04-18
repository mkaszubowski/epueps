class AddPositionToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :position, :int
  end
end
