module Api
  module V1
    module ErrorHandler
      extend ActiveSupport::Concern

      included do
        helper_method :item_not_found,
                      :missing_params
      end

      rescue_from ActiveRecord::RecordNotFound do |e|
        render_json_error :not_found, item_not_found
      end

      rescue_from ActionController::ParameterMissing do |e|
        render_json_error :bad_request, missing_params
      end
    end
  end
end