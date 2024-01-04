class Address < ApplicationRecord

  validates :name, :line1, :city, :postal_code, :country, presence: true

  def to_stripe
    {
      city: city,
      country: country,
      line1: line1,
      name: name,
      postal_code: postal_code,
      state: state
    }
  end

  def build_address_string
    <<~TXT.freeze
      #{self.line1}
      #{self.city} #{self.postal_code}
      #{self.country}
    TXT
  end
end
