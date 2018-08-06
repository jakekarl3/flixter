class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    current_course = current_lesson.section.course
    enrollment = Enrollment.find_by(course: current_course, user: current_user)
    if enrollment.nil?
      redirect_to course_path(current_course), alert: "You must be enrolled in this course before you can view the lessson."
    end
  end

  private

  helper_method :current_lesson
  def current_lesson
    @current_lesson ||= Lesson.find(params[:id])
  end
end
