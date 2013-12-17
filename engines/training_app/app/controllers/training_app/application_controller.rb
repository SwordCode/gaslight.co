class TrainingApp::ApplicationController < ApplicationController
  protect_from_forgery

  before_filter :redirect_to_ssl

  def redirect_to_ssl
    redirect_to protocol: 'https' if ssl_required?
  end

  def ssl_required?
    (Rails.env.production? || Rails.env.staging?) && !request.ssl?
  end

  def raise_not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end

