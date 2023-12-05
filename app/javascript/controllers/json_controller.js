import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="json"
export default class extends Controller {
  static values = { payload: String }
  connect() {
    this.payload = JSON.parse(this.payloadValue)
    console.log("Parsed JSON payload, it's now an object:")
    console.log(this.payload)
    console.log("You can access the attributes, exp name:")
    console.log(this.payload.name)
  }
}
