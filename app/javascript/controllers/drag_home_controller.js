import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="drag-home"
export default class extends Controller {
  static targets = ["dragging"]

  connect() {
    console.log("Drag Home - connected")
    console.log(this.draggingTarget)
    this.dragginTarget.scrollIntoView({behavior:"smooth"});
  }

  reveal() {
    console.log("You're dragging right now")



  }





}
