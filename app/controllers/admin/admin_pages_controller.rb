module Admin
  class AdminPagesController < BaseController
    def home
      @subject_count = Subject.all.count
      @lesson_count = Lesson.all.count
      @video_count = Video.all.count
      @user_count = User.all.count
    end
  end
end
