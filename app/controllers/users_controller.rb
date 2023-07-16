# User　コントローラー定義
# TODO: 2023/06/05 作成開始
class UsersController < ApplicationController
  skip_before_action :authorize_request, only: [:create], raise: false

  # ログインしているUSER
  def current
    render json: @current_user.as_json(root: true)
  end

  # USER登録時
  def create
    @user = User.new(user_params)

    if @user.save
      render json: @user.as_json(root: true), status: :created
    else
      render json: { errors: @user.errors }, status: :unprocessable_entity
    end
  end

  # USER情報の変更
  def custom_update
    if @current_user.update(user_params)
      render json: @current_user.as_json(root: true)
    else
      render json: @current_user.errors, status: :unprocessable_entity
    end
  end

  private

  # 必要なjsonのみ引数として取り出す
  def user_params
    params.require(:user).permit(:username, :email, :password, :image, :bio)
  end
end
