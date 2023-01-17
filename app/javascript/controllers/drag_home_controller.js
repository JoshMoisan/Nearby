import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drag-home"
export default class extends Controller {
  static targets = ["dragging"]

  connect() {
    console.log("Drag Home - connected")
    this.draggingTarget.scrollIntoView({behavior:"smooth"});
    
  }
}
