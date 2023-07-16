class ApplicationController < ActionController::API
  # TODO: JWT関連の処理を追加
  # サーバー側でクッキーを使えるようにする。
  include ActionController::Cookies

  before_action :authorize_request

  # 認証済み（USER登録済み）かを確認
  def authorize_request

    # CookieからJWTを取得
    token = cookies[:token]

    # 秘密鍵の取得
    rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))

    # JWTのデコード。JWTからペイロードが取得できない場合は認証エラーにする
    begin
      decoded_token = JWT.decode(token, rsa_private, true, { algorithm: 'RS256' })
    rescue JWT::DecodeError, JWT::ExpiredSignature, JWT::VerificationError
      return render json: { message: 'unauthorized' }, status: :unauthorized
    end

    # subクレームからユーザーIDを取得
    user_id = decoded_token.first["sub"]

    # ユーザーを検索
    @user = User.find(user_id)

    # userが取得できない場合は認証エラー
    if @user.nil?
      render_unauthorized
    else
      @current_user = @user
    end
  end

  # 自身の投稿か等を調べる
  def owner?(model)
    model.user_id == @current_user.id
  end

  def render_unauthorized
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end
end