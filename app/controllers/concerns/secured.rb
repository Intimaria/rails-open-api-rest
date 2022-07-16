module Secured
    extend ActiveSupport::Concern
    @token

    # included do
    #   before_action :authenticate_request!
    # end
  
    private
  
    def authenticate_request!
      @token = AuthorizationService.new(request.headers).authenticate_request!
      @token.symbolize_keys!
    rescue JWT::VerificationError, JWT::DecodeError
      render json: { errors: ['Not Authenticated'] }, status: :unauthorized
    end
  
  end

