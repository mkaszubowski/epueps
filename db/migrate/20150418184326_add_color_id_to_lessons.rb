class AddColorIdToLessons < ActiveRecord::Migration
  def change
    add_column :lessons, :color_id, :integer
  end
end
