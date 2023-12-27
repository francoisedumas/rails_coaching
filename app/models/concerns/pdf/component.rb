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

  def half_width_table(title:, content:, position: :left, move_down: true, index: nil)
    @y_position -= TABLE_LINE_HEIGHT + 10 if move_down
    @x_position = position == :right ? INNER_PAGE_WIDTH / 2 : 0

    box(height: DATA_TABLE_HEIGHT, width: INNER_PAGE_WIDTH / 2) do
      @document.move_down 10
      @document.indent(5) do
        @document.float { @document.text " #{index}." } if index
        @document.indent(15) do
          @document.text title
          @document.move_down 20
          @document.text content, style: :bold
        end
      end
    end
  end
end
