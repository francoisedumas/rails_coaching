class ApiViewerController < ApplicationController
  def index
    country = params[:country]
    filtered_data = cache_answer.select { |entry| entry['currentCountry'] == country } if country.presence
    @pagy, @vessels = pagy_array(filtered_data || cache_answer)
    @country_filter = cache_country_filter
  end

  private

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

  def local_answer
    path = Rails.root.join("tmp", "api_response.json")
    file_content = File.read(path)
    JSON.parse(file_content)
  end
end
