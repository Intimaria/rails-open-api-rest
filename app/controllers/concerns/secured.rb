module Secured
    extend ActiveSupport::Concern
  
    included do
      before_action :authenticate_request!
    end
  
    private
  
    def authenticate_request!
      AuthorizationService.new(request.headers).authenticate_request!
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  
  end

