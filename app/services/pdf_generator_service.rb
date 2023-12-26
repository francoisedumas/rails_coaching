class PdfGeneratorService
  MONTSERRAT_FONT_PATH = 'app/assets/stylesheets/Montserrat-Medium.ttf'
  MONTSERRAT_BOLD_FONT_PATH = 'app/assets/stylesheets/Montserrat-Black.ttf'
  LOGO_IMG_PATH = 'app/assets/images/logo.png'
  def initialize
    @pdf = Prawn::Document.new
    @document_width = @pdf.bounds.width # width fo the document
    @pdf.font_families.update(
      'montserrat' => {
        normal: MONTSERRAT_FONT_PATH, # Path to the normal (regular) font style
        bold: MONTSERRAT_BOLD_FONT_PATH # Path to the bold font style (if applicable)
      }
    )
  end

  def generate_pdf
    header
    mid_section
    lower_section
    @pdf.render
  end

  private

  def header
    status_results = [%w[15 3 5 4 3], %w[TESTS FAILED PASSED BLOCKED UNKNOWN]]
    text_colors = { 1 => 'C8102F', 2 => '83BC41', 3 => 'FDB357', 4 => 'BBBBBB' }

    header_table = @pdf.make_table(status_results) do |table|
      table.row(0).font_style = :bold
      table.row(0).font = 'montserrat'

      header_status_rows = [0, 1]
      header_status_rows.each do |row_index|
        text_colors.each do |column_index, color|
          table.row(row_index).column(column_index).style(text_color: color)
        end
      end

      table.row(0..1).border_width = 0
      table.row(0..1).column(0).border_width = 1
      table.row(0..1).column(0).border_color = 'c0c5ce'
      table.row(0..1).column(0).borders = [:right]
      table.row(0).size = 17
      table.row(1).size = 11
    end

    header_column_widths = [@document_width * 2 / 3, @document_width * 1 / 3]
    header_title_data = [['Execution Summary']]
    header_title_options = {
      column_widths: [@document_width],
      row_colors: ['EDEFF5'],
      cell_style: {
        border_width: 0,
        padding: [15, 12, 1, 20],
        size: 20,
        font: 'montserrat',
        font_style: :normal
      }
    }

    header_logo_data = [[header_table, { image: LOGO_IMG_PATH, position: :center, scale: 0.5, colspan: 6 }]]
    header_logo_options = {
      column_widths: header_column_widths,
      row_colors: ['EDEFF5'],
      cell_style: {
        border_width: 2,
        padding: [15, 15],
        borders: [:bottom],
        border_color: 'c9ced5'
      }
    }

    @pdf.table(header_title_data, header_title_options)
    @pdf.table(header_logo_data, header_logo_options)
  end

  def mid_section
    mid_section_data = [['General', '', ''], ['Start time:', 'Duration:', 'Executed by:'],
              ["Apr 7, 2020 \n 10:33:57", '15m 9s', 'z-automation-sayvr@perfectmobile.com']]

    mid_section_options = {
     width: @document_width,
     row_colors: ['ffffff'],
     cell_style: {
      border_width: 0,
      borders: [:bottom],
      border_color: 'c9ced5',
      padding: [10, 15]
     }
    }

    @pdf.table(mid_section_data, mid_section_options) do |table|
     table.row(0).border_width = 0.5
     table.row(1).text_color = '888892'
     table.row(0).padding = [10, 15]
     table.row(2).size = 11
    end
   end


   def lower_section
    report_data = [['Report', '', 'View detailed list in new Reporting'],
           ['Name', 'Platform', 'Status'],
           ['gehpbatosid4pp_oak6f', "Apple Chibn \n f7euq", 'BLOCKED'],
           ['gehpbatosid4pp_oak6f', "Apple Chibn \n f7euq", 'PASSED']]

    report_data_options = {
     width: @document_width,
     row_colors: ['ffffff'],
     cell_style: {
      border_width: 1,
      borders: [:bottom],
      border_color: 'c9ced5'
     }
    }

    @pdf.table(report_data, report_data_options) do |table|
     test_status = table.rows(1..-1).column(-1)
     test_status.filter do |cell|
      case cell.content
      when 'BLOCKED'
       cell.text_color = 'FDB357'
      when 'PASSED'
       cell.text_color = '83BC41'
      end
     end

     table.row(0..1).border_width = 0.5
     table.row(0).column(2).text_color = '2787c4'
     table.row(0).column(2).size = 11
     table.row(1).background_color = 'EDEFF5'
     table.row(1..-1).column(1..2).align = :center
     table.row(1).text_color = '465579'
     table.row(1).size = 10
     table.row(1..-1).padding = [10, 15]
     table.row(0).padding = [7, 15]
    end
   end
end
