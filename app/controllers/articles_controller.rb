require_relative '../repositories/article_repository'

class ArticlesController < ApplicationController
  include Paginable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[show edit update destroy]

  def initialize
    super
    @repo = ArticleRepository.new
  end

  def index
    @categories = Category.sorted

    category_id = params[:category]
    @highlights = @repo.find_articles_by_category(category_id, 3)

    highlights_id = @highlights.pluck(:id).join(',')

    @articles = @repo.articles_without_highlits(
      highlights_id, category_id, current_page
    )
  end

  def show; end

  def new
    @article = current_user.articles.new
  end

  def create
    @article = current_user.articles.new(article_params)

    if @article.save
      redirect_to @article, notice: 'Article was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @article.update(article_params)
      redirect_to @article, notice: 'Article was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @article.destroy

    redirect_to root_path, notice: 'Article was successfully destroyed.'
  end

  private

  def article_params
    params.require(:article).permit(:title, :body, :category_id)
  end

  def set_article
    @article = Article.find(params[:id])
    authorize @article
  end
end
