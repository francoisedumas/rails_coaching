class Pdf
  include Pdf::Header
  include Pdf::Component
  include Pdf::Constants

  attr_reader :document

  def initialize
    @document = Prawn::Document.new(PDF_CONFIG.merge(info: metadata))
    document.line_width = LINE_WIDTH
    @x_position = 0
    @y_position = INNER_PAGE_HEIGHT
    document.font "Times-Roman"
  end

  def build
    header

    document.render
  end

  def self.build
    new.build
  end

  private

  def metadata
    {
      Title:        "vessel_contract_111",
      Author:       "flying_boat",
      Creator:      "diving_boat",
      Producer:     "surfing_boat",
      CreationDate: "01/01/2024"
    }
  end
end
