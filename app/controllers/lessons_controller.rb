class LessonsController < ApplicationController
  before_action :logged_in_user

  def new
  end

  def edit
    @lesson = Lesson.find params[:id]
  end

  def create
    @lesson = current_user.lessons.build category_id: params[:category_id]
    if @lesson.save
      redirect_to edit_lesson_path @lesson.id
    else
      redirect_to :back
    end
  end

  def update
    @lesson = Lesson.find params[:id]
    if @lesson.update_attributes params_lesson
      redirect_to lesson_path @lesson
    else
      flash[:error] = t :lesson_update_error
      redirect_to categories_path
    end
  end

  def show
    @lesson = Lesson.find params[:id]
    @lesson_words = @lesson.lesson_words.answered
  end

  private
  def params_lesson
    params.require(:lesson).permit :category_id, lesson_words_attributes: [:id, :answer_id]
  end
end
