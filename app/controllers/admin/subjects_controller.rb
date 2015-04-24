module Admin
  class SubjectsController < BaseController
    load_and_authorize_resource

    def index
      @subjects = SortAndFilterData.call(Subject.not_deleted, params)
    end

    def trash
      @subjects = SortAndFilterData.call(Subject.deleted, params)
      render 'index'
    end

    def destroy
      if @subject.destroy
        flash[:success] = 'Usunięto przedmiot'
        redirect_to :back
      else 
        flash[:error] = 'Wystąpił błąd, spróbuj ponownie'
      end
    end

    def new
      @subject = Subject.new
    end

    def create
      @subject = Subject.new(subject_params)

      if @subject.save
        flash[:success] = 'Dodano przedmiot'
        redirect_to admin_subjects_path and return
      elsif @subject.errors.any?
        flash.now[:error] = 'Wystąpił błąd' 
        render 'new'
      end

    end

    def update
      if @subject.update_attributes(subject_params)
        flash[:success] = 'Zaktualizowano przedmiot'
        redirect_to admin_subjects_path
      else
        flash.now[:error] = 'Wystąpił błąd'
        render 'edit'
      end
    end

    def publish
      # it needs refactoring
      if @subject.publish
        flash[:success] = "Opublikowano przedmiot"
      else
        flash[:error] = "Wystąpiły błędy. Popraw je, a następnie opublikuj przedmiot"
        params[:subject] = @subject
        render 'edit' and return
      end

      redirect_to admin_subjects_path
    end


    private

    def subject_params
      params.require(:subject).permit(:name,
                                      :intro_video_link,
                                      :description,
                                      :image)
    end

    def set_subject
      @subject = Subject.find(params[:id])

      if @subject.nil?
        flash[:error] = 'Nie znaleziono takiego przedmiotu'
        redirect_to admin_subjects_path
      end
    end
  end
end
