class Pdf
  include Pdf::Header
  include Pdf::Component
  include Pdf::Constants

  attr_reader :document

  OTHER_ADDRESS = <<-TXT.freeze
    Avenue du petit Lu
    44000 Nantes
    BRETAGNE
  TXT

  def initialize(address:)
    @address = address
    @document = Prawn::Document.new(PDF_CONFIG.merge(info: metadata))
    document.line_width = LINE_WIDTH
    @x_position = 0
    @y_position = INNER_PAGE_HEIGHT
    document.font "Times-Roman"
  end

  def build
    header
    half_width_table(title: "Owner place", content: @address.build_address_string)
    half_width_table(title: "Customer place", content: OTHER_ADDRESS, position: :right, move_down: false)

    document.render
  end

  def self.build(address:)
    new(address:).build
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
