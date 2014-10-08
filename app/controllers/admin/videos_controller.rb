class Admin::VideosController < ApplicationController

  include Admin

  layout 'admin'

  before_action :authenticate_admin
  before_action :set_instance_variables, 
                only: [:edit, :update, :destroy]

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
      flash[:success] = "Dodano film"
      redirect_to admin_subject_lesson_path(@subject, @lesson) and return
    elsif @video.errors.any?
      flash.now[:error] = "Wystąpiły błędy w formularzu"
    else
      flash.now[:error] = "Wystąpił nieznany błąd"
    end

    render 'new'
  end

  def edit
  end

  def update
    if @video.update_attributes(video_params)
      flash[:success] = "Zaktualizowano film"
      redirect_to admin_subject_lesson_path(@subject, @lesson) and return
    elsif @video.errors.any?
      flash.now[:error] = "Wystąpiły błędy w formularzu"
    else
      flash.now[:error] = "Wystąpił nieznany błąd"
    end

    render 'edit'
  end


  def destroy
    if @video.destroy
      flash[:success] = "Usunięto film"
    else
      flash[:error] = "Wystąpił błąd. Spróbuj ponownie później"
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
