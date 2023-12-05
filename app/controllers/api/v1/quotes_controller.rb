class Api::V1::QuotesController < ApplicationController
  def index
    quotes = Quote.all

    sleep 3
    render json: quotes
  end
end
