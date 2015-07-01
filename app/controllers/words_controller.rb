class WordsController < ApplicationController
  def index
    @categories = Category.all
    @filter = Settings.filters
    list_word = params[:filter_type].present? ?
      Word.filter_category(params[:category_id]).send(params[:filter_type], current_user) : Word.all
    @words = list_word.paginate page: params[:page], per_page: Settings.words_per_page
  end
end
