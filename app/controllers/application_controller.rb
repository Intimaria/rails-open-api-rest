# require 'json_web_token'

class ApplicationController < ActionController::API
    respond_to? :json

    # rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
    # rescue_from ActionController::ParameterMissing, with: :parameter_missing

    private

    #errors 
    # def record_not_found(error)
    #   render json: { error: error.message }, status: :not_found
    # end

    # def parameter_missing(error)
    #     render json: { error: error.message }, status: :unprocessable_entity
    # end


end
