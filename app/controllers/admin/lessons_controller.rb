module Admin
  class LessonsController < BaseController
    include CurrentVideo

    authorize_resource

    before_action :set_lesson,
                  only: [:show, :destroy, :sort, :edit, :update]
    before_action :set_subject,
                  only: [:show, :new, :create]

    def show
      @videos = @lesson.videos
    end

    def new
      @lesson = Lesson.new
    end

    def create
      @lesson = @subject.lessons.build(lesson_params)

      if @lesson.save
        flash[:success] = 'Dodano lekcję'
        redirect_to admin_subject_path(@subject)
      else
        flash[:error] = 'Wystąpił błąd'
        render 'new'
      end
    end

    def destroy
      @lesson = Lesson.find(params[:id])

      if @lesson.destroy
        flash[:success] = 'Usunięto lekcję'
        redirect_to admin_subject_path(@lesson.subject)
      else
        flash[:error] = 'Wystąpił błąd. Spróbuj ponownie później'
      end
    end

    def sort
      @subject = @lesson.subject

      if params[:position] == 'up'
        @lesson.move_higher
      else
        @lesson.move_lower
      end
    end

    def edit
    end

    def update
      if @lesson.update_attributes(lesson_params)
        flash[:success] = 'Zaktualizowano lekcję'
        redirect_to admin_subject_path(@subject)
      elsif @lesson.errors.any?
        flash.now[:error] = 'Wystąpiły błędy w formularzu'
        render 'edit'
      else
        flash.now[:error] = 'Wystąpił nieznany błąd. Spróbuj ponownie później'
        render 'edit'
      end
    end

    private

    def lesson_params
      params.require(:lesson).permit(:name, :video_link, :description)
    end

    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    def set_subject
      @subject = Subject.find(params[:subject_id])
    end
  end
end
