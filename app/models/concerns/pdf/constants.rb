module Pdf::Constants
  PDF_CONFIG = {
    page_size:    "A4",
    page_layout:  :portrait,
    top_margin:   8,
    left_margin:  16,
    right_margin: 16
  }.freeze

  INNER_PAGE_HEIGHT = 800
  INNER_PAGE_WIDTH = 564
  TABLE_LINE_HEIGHT = 26
  DATA_TABLE_HEIGHT = 230
  LOGO_WIDTH = 150
  LOGO_HEIGHT = 95
  LINE_WIDTH = 0.5
end
