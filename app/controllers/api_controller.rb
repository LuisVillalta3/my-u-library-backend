class ApiController < ApplicationController
  rescue_from ActionController::RoutingError do |e|
    render_json_error :not_found, :route_not_found
  end

  def render_json_error(status, error_code, extra = {})
    status = Rack::Utils::SYMBOL_TO_STATUS_CODE[status] if status.is_a? Symbol

    error = {
      message: I18n.t("error_messages.#{error_code}.message"),
      status: status,
    }.merge(extra)

    detail = I18n.t("error_messages.#{error_code}.detail", default: '')
    error[:detail] = detail unless detail.empty?

    render json: { errors: [error] }, status: status
  end
end
