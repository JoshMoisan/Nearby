import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drag-home"
export default class extends Controller {
  static targets = ["dragging"]

  connect() {
    this.draggingTarget.scrollIntoView({behavior:"smooth"});
  }
}
