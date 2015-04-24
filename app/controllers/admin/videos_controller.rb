module Admin
  class VideosController < BaseController
    load_and_authorize_resource

    def new
      @video = Video.new
      @lesson = Lesson.find(params[:lesson_id])
      @subject = @lesson.subject
    end

    def create
      @lesson = Lesson.find(params[:lesson_id])
      @subject = @lesson.subject
      @video = @lesson.videos.build(video_params)

      if @video.save
        flash[:success] = 'Dodano film'
        redirect_to admin_subject_lesson_path(@subject, @lesson) and return
      else
        flash.now[:error] = 'Wystąpił błąd'
        render 'new'
      end
    end

    def edit
    end

    def update
      if @video.update_attributes(video_params)
        flash[:success] = 'Zaktualizowano film'
        redirect_to admin_subject_lesson_path(@subject, @lesson) and return
      else
        flash.now[:error] = 'Wystąpił błąd'
        render 'edit'
      end
    end


    def destroy
      if @video.destroy
        flash[:success] = 'Usunięto film'
      else
        flash[:error] = 'Wystąpił błąd. Spróbuj ponownie później'
      end

      redirect_to admin_subject_lesson_path(@subject, @lesson)
    end


    private


    def video_params
      params.require(:video).permit(:name, :link, :signed_in_only)
    end

    def set_instance_variables  
      @video = Video.find(params[:id])
      @lesson = @video.lesson
      @subject = @lesson.subject
    end 
  end
end
