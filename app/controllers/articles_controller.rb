class ArticlesController < ApplicationController
  before_action :set_article!, only: %i[show update destroy favorite unfavorite]

  # 投稿記事一覧
  def index
    @articles = Article.order(created_at: :desc).includes(:user)
    @articles = @articles.offset(params[:offset]).limit(params[:limit]) if params[:offset].present? and params[:limit].present?

    render_articles
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      render_article
    else
      render json: { errors: @article.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    render_article
  end

  # 記事更新
  def update
    unless owner?(@article)
      render_unauthorized and return
    end

    if @article.update(article_params)
      render_article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def destroy
    unless owner?(@article)
      render_unauthorized and return
    end

    @article.destroy
  end

  private

  def set_article!
    @article = Article.find_by_slug(params[:slug])
  end

  def article_params
    params.require(:article).permit(:title, :description, :body, tagList: [])
  end

  # 記事一件
  def render_article
    render json: { article: @article.as_json({}, @current_user) }
  end

  # 記事複数
  def render_articles
    render json: { articles: @articles, articlesCount: @articles.count }
  end

end
