module Pdf::Component
  extend ActiveSupport::Concern
  include Pdf::Constants

  def box(width: INNER_PAGE_WIDTH, height: TABLE_LINE_HEIGHT, strokes: true, &block)
    original_block = block

    # draw the border of the box
    if strokes
      block = proc do
        document.stroke_bounds
        original_block.call
      end
    end

    document.bounding_box([@x_position, @y_position], width: width, height: height, &block)
    @x_position += width
  end
end
