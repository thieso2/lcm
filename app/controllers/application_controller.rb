class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  before_filter :authenticate_user!
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_filter :reload_libs #, :if => defined? RELOAD_LIBS
  before_action :set_locale

  helper :show_object

  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  #def current_user
  #  puts "Pundit is looking for current_user"
  #  current_person
  #end

  private

  def user_not_authorized(exception)
    policy_name = exception.policy.class.to_s.underscore
    # flash[:warning]
    f = t "#{policy_name}.#{exception.query}", scope: "pundit",
            default: [:default, "War nix"], policy: policy_name, method: exception.query
    redirect_to(request.referrer || root_path,  alert: f)
  end

  def configure_permitted_parameters
    puts "!!!!Checking params"
    devise_parameter_sanitizer.for(:sign_up) {|u|
      u.permit(:email, :password, :password_confirmation)
    }
    devise_parameter_sanitizer.for(:account_update) {|u|
      u.permit(:email, :password, :password_confirmation, :current_password)
    }
  end

  def reload_libs
    if Rails.env.development?
      RELOAD_LIBS.each do |lib|
        require_dependency lib
      end
    end
  end

  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end

end
