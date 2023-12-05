# frozen_string_literal: true

class ApiViewerService < BaseService
  BASE_API_URL = "https://spinwind-ge.spinergie.com/base/api/".freeze
  DEFAULT_SUB_PATH = "construction-specs".freeze
  CONTENT_TYPE = "application/json".freeze

  def initialize(options = {})
    @base_api_url = options[:base_api_url] || BASE_API_URL
    @api_key = options[:api_key] || Rails.application.credentials.demo_api_key
    @sub_path = options[:sub_path] || DEFAULT_SUB_PATH
    @content_type = options[:content_type] || CONTENT_TYPE
  end

  def call
    make_api_request
  end

  private

  def make_api_request
    response = HTTParty.get("#{BASE_API_URL}#{@sub_path}", headers: default_headers)
    handle_response(response)
  rescue Errno::ECONNREFUSED
    raise CustomApiException, "API not available"
  end

  def handle_response(response)
    response = HTTParty.get("https://spinwind-ge.spinergie.com/base/api/#{@sub_path}", headers: default_headers)
    case response.code
    when 404
      "URL not found! 😱"
    when 500...600
      "ZOMG ERROR #{response.code}"
    else
      JSON.parse(response.body)
    end
  rescue Errno::ECONNREFUSED
    "API not available"
  end

  def default_headers
    {
      "Accept" => @content_type,
      "Content-Type" => @content_type
    }.merge(authorization_header)
  end

  def authorization_header
    {"apiKey" => @api_key}
  end
end
