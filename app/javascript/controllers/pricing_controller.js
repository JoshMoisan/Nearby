import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pricing"
export default class extends Controller {
  static targets = ["price", "days", "total"]

  connect() {
  }

  pricePreview() {
    const price = this.priceTarget.dataset.price
    const duration = this.daysTarget.value
    const bookingPrice = price * duration
    this.totalTarget.innerHTML = `${price} <i class="fa-solid fa-coins"></i> /day = ${bookingPrice} <i class="fa-solid fa-coins"></i>`
  }
}
