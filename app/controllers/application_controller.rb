class ApplicationController < ActionController::Base
  include DeviseTokenAuth::Concerns::SetUserByToken
  # before_action :configure_permitted_parameters, if: :devise_controller?
  # protect_from_forgery with: :exception
  # before_action :authenticate_user! , :except=>[:new, :create]
  protect_from_forgery with: :null_session

  # skip_before_action :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }
end
