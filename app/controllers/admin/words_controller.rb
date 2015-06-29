class Admin::WordsController < ApplicationController
  before_action :required_admin
  before_action :set_word, except: [:index, :new, :create]

  def index
    @words = Word.paginate page: params[:page], per_page: Settings.words_per_page
  end

  def show
  end

  def new
    if (@categories = Category.all).any?
      @word = Word.new
      @word.answers.build
    else
      flash[:danger] = t :must_have_category
      redirect_to new_admin_category_path
    end
  end

  def create
    @word = Word.new word_params
    if @word.save
      flash[:success] = t :word_create_success
      redirect_to admin_words_path
    else
      render "new"
    end
  end

  def edit
    @categories = Category.all
  end

  def update
    if @word.update word_params
      flash[:success] = t :word_update_success
      redirect_to admin_words_path
    else
      render "edit"
    end
  end

  def destroy
    @word.destroy
    flash[:success] = t :word_delete_success
    redirect_to admin_words_path
  end

  private
  def set_word
    @word = Word.find params[:id]
  end

  def word_params
    params.require(:word).permit :jp_word, :category_id,
      answers_attributes: [:id, :answer_content, :correct, :_destroy]
  end
end
