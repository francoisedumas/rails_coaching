class AddressesController < ApplicationController
  def new
  end

  def create
    @address = Address.new(address_params)

    if @address.save
      redirect_to address_path(@address)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def download
    @address = Address.find(params[:id])
    render_pdf = Pdf.build(address: @address)

    send_data(
      render_pdf,
      filename:    "my_contract",
      type:        "application/pdf",
      disposition: "inline"
    )
  end

  private

  def address_params
    params.require(:address).permit(:name, :line1, :city, :state, :postal_code, :country)
  end
end
