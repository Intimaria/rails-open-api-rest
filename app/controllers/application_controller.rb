require 'json_web_token'

class ApplicationController < ActionController::API
    respond_to? :json

    #authorization 
    def authorize!
      valid, result = verify(raw_token(request.headers))
  
      render json: { message: result }.to_json, status: :unauthorized unless valid

      @token ||= result
    end
  
    #errors 
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

    rescue_from ActionController::ParameterMissing, with: :parameter_missing

    private

    #authorization 
    def verify(token)
      payload, = JsonWebToken.verify(token)
      [true, payload]
    rescue JWT::DecodeError => e
      [false, e]
    end
  
    def raw_token(headers)
      return headers['Authorization'].split.last if headers['Authorization'].present?
  
      nil
    end

    #errors 
    def record_not_found(error)
      render json: { error: error.message }, status: :not_found
    end

    def parameter_missing(error)
        render json: { error: error.message }, status: :unprocessable_entity
    end


end
