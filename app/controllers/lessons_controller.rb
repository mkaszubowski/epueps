class LessonsController < ApplicationController
  respond_to :json

  before_action :set_subject

  def index
    lessons = @subject.lessons.includes(:videos)
    render json: lessons
  end

  protected

  def set_subject
    @subject = Subject.find(params[:subject_id])
  end
end
