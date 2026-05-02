module Api
  module V1
    class BaseController < ApplicationController
      before_action :authenticate_api_token!

      # CSRF 토큰 검증 비활성화 (API는 토큰으로 인증)
      protect_from_forgery with: :null_session

      rescue_from ActiveRecord::RecordNotFound do |e|
        render json: { error: '섹션을 찾을 수 없습니다.', detail: e.message }, status: :not_found
      end

      rescue_from ActionController::ParameterMissing do |e|
        render json: { error: '필수 파라미터가 누락되었습니다.', detail: e.message }, status: :bad_request
      end

      private

      def authenticate_api_token!
        token = request.headers['X-API-Token'] || params[:api_token]
        return if token == RAIL_API_TOKEN

        render json: { error: '인증이 필요합니다. X-API-Token 헤더를 확인하세요.' }, status: :unauthorized
      end
    end
  end
end
