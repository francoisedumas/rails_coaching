class PdfsController < ApplicationController

  def show
  end

  def download
    render_pdf = PdfGeneratorService.new.generate_pdf

    send_data(
      render_pdf,
      filename:    "my_contract",
      type:        "application/pdf",
      disposition: "inline"
    )
  end
end
