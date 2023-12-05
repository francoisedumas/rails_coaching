import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="flag"
export default class extends Controller {
  static targets = [ "flag" ]
  static values = {
    country: String
  }

  connect() {
    console.log(this.countryValue)
    this.flagTarget.textContent = this.getFlagEmoji(this.countryValue)
  }

  getFlagEmoji(countryCode) {
    const codePoints = countryCode
      .toUpperCase()
      .split('')
      .map(char =>  127397 + char.charCodeAt());
    return String.fromCodePoint(...codePoints);
  }
}
