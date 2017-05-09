class Api::BaseController < ApplicationController
  # to identify HTML forms that are created by your rails app, rails adds a
  # hidden field that contains a CSRF token (cross-site request forgery)
  # For a json api, we want to skip this security check and use our own. This
  # is necessary , otherwise Rails will disallow all POST requests made without
  # a CSRF token signed with rails secret from 'config/secret.yml'
skip_before_filter :verify_authenticity_token
before_action :authenticate_user

  private

  def authenticate_user
    @user = User.find_by_api_token params[:api_token]
    head :unauthorized if @user.nil?
  end
end
