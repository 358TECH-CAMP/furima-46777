class ApplicationController < ActionController::Base
  # Devise使用時のみ、追加パラメータを許可する
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Basic認証（本番・開発環境のアクセス制限）
  before_action :basic_auth

  protected

  # Deviseに「保存してよいカラム」を教える
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [
        :nickname,
        :last_name,
        :first_name,
        :last_name_kana,
        :first_name_kana,
        :birth_date
      ]
    )
  end

  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == ENV['BASIC_AUTH_USER'] && password == ENV['BASIC_AUTH_PASSWORD'] # 環境変数を読み込む記述に変更
    end
  end
end
