class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Token::ControllerMethods

  TOKEN=ENV['TOKEN']

  private

  def authenticate
    authenticate_or_request_with_http_token do |token, options|
      ActiveSupport::SecurityUtils.secure_compare(token, TOKEN)
    end
  end
  
end
