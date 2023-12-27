module Pdf::Header
  extend ActiveSupport::Concern
  include Pdf::Constants

  def header
    customer_image if customer_image_path

    @y_position -= 25
    @document.text_box "SUPPLYTIME 2017", align: :left, size: 32, style: :bold, at: [0, @y_position]

    @y_position -= 35
    @document.text_box "TIME CHARTER PARTY FOR", align: :left, size: 10, style: :bold, at: [0, @y_position]
    @y_position -= 10
    @document.text_box "OFFSHORE SUPPORT VESSELS", align: :left, size: 10, style: :bold, at: [0, @y_position]
    @y_position -= 20
    @document.text_box "PART I", align: :left, size: 10, style: :bold, at: [0, @y_position]

    @y_position -= 20
    box(width: INNER_PAGE_WIDTH, strokes: false) { @document.stroke_horizontal_rule }
  end

  def customer_image_path
    image_path = Rails.root.join("app/assets/images/own.png")
    return image_path if File.exist? image_path

    nil
  end

  def customer_image
    coordinates = [INNER_PAGE_WIDTH - LOGO_WIDTH, INNER_PAGE_HEIGHT - 10]

    document.bounding_box(coordinates, width: LOGO_WIDTH, height: LOGO_HEIGHT) do
      document.image(customer_image_path, fit: [LOGO_WIDTH, LOGO_HEIGHT], vposition: :center)
    end
  end
end
