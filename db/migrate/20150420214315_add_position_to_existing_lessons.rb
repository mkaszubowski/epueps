class AddPositionToExistingLessons < ActiveRecord::Migration
  def change
    Lesson.all.map(&:save)
  end
end
