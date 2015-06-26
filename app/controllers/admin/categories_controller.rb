class Admin::CategoriesController < ApplicationController
  before_action :required_admin
  before_action :set_category, except: [:index, :new, :create]

  def index
    @categories = Category.paginate page: params[:page], per_page: Settings.categoies_per_page
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new categoty_params
    if @category.save
      flash[:success] = t :category_create_success
      redirect_to admin_categories_path
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @category.update categoty_params
      flash[:success] = t :category_update_success
      redirect_to admin_categories_path
    else
      render "edit"
    end
  end

  def destroy
    @category.destroy
    flash[:success] = t :category_delete_success
    redirect_to admin_categories_path
  end

  private
  def set_category
    @category = Category.find params[:id]
  end

  def categoty_params
    params.require(:category).permit :title, :description
  end
end
