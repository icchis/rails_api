class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # protect_from_forgery with: :exception
  # skip_before_filter :verify_authenticicity_token
  # csrf対策の無効化
  # before_filter :authenticate_user!
  # protect_from_forgery with: :null_session
  protect_from_forgery with: :null_session, :if => Proc.new { |c| c.request.format == 'application/json' }
  skip_before_action :verify_authenticity_token, if: :json_request?

  before_filter :authenticate_user_from_token!
  # before_filter :authenticate_user!

  before_filter :configure_permitted_parameters, if: :devise_controller?

  private

  def authenticate_user_from_token!
    user_email = params[:user_email].presence
    user = user_email && User.find_by_email(user_email)

    # タイミング攻撃を防ぐためにトークンの照合にDevise.secure_compareを使う
    if user && Devise.secure_compare(user.authentication_token, params[:user_token])
      sign_in user, store: false
    end
  end

  protected

  def json_request?
    request.format.json?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in).push(:my_latitude, :my_longitude)
  end
end
