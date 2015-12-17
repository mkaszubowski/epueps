class AddInitialPositionToVideos < ActiveRecord::Migration
  def change
    Lesson.all.each do |lesson|
      lesson.videos.each_with_index do |video, index|
        video.update_attribute(:position, index)
      end
    end
  end
end
