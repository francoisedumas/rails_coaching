import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quotes"
export default class extends Controller {
  connect() {
    this.element.innerText = "Loading quotes...";

    fetch('/api/v1/quotes')
      .then(response => response.json())
      .then(quotes => {
        const quoteNames = quotes.map(quote => quote.name).join(', ');
        this.element.innerText = quoteNames;
      });
  }
}
