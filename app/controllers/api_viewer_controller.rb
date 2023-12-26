class ApiViewerController < ApplicationController
  before_action :load_filtered_data, only: :index

  def index
    @pagy, @vessels = pagy_array(@filtered_data)
    @country_filter = cache_country_filter
    @status_filter = cache_status_filter
  end

  private

  def load_filtered_data
    @filtered_data = cache_answer
    apply_filters
  end

  def apply_filters
    @filtered_data = @filtered_data.select { |entry| entry['currentCountry'] == params[:country] } if params[:country].present?
    @filtered_data = @filtered_data.select { |entry| entry['vesselStatus'] == params[:status] } if params[:status].present?
    @filtered_data = @filtered_data.select { |entry| entry['vessel']&.downcase&.include?(params[:name].downcase) } if params[:name].present?
  end

  def cache_answer
    Rails.cache.fetch("api_response", expires_in: 12.hours) do
      ApiViewerService.call(sub_path: "construction-specs")
    end
  end

  def cache_country_filter
    Rails.cache.fetch("api_country_filter", expires_in: 12.hours) do
      cache_answer.pluck('currentCountry').uniq.compact.sort
    end
  end

  def cache_status_filter
    Rails.cache.fetch("api_status_filter", expires_in: 12.hours) do
      cache_answer.pluck('vesselStatus').uniq.compact.sort
    end
  end

  def local_answer
    path = Rails.root.join("tmp", "api_response.json")
    file_content = File.read(path)
    JSON.parse(file_content)
  end
end
