class SessionsController < ApplicationController
  skip_before_action :authorize_request, raise: false

  # ログイン時の処理
  def login

    # ユーザの取得
    @user = User.find_by_email(params[:email])

    if @user&.authenticate(params[:password])

      # ペイロードの作成
      payload = {
        iss: "nakamotorealworld_app",
        sub: @user.id,
        exp: (DateTime.current + 7.days).to_i # JWTの有効期限
      }

      # 秘密鍵の取得
      rsa_private = OpenSSL::PKey::RSA.new(File.read(Rails.root.join('auth/service.key')))

      # JWTの作成
      token = JWT.encode(payload, rsa_private, "RS256")

      # JWTをCookieにセット
      cookies[:token] = token
      render json: @user.as_json.merge({ token: token }), status: :ok
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  end
end