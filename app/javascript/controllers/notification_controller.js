import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

let message = 0
export default class extends Controller {
  static values = { userId: Number }
  static targets = ["bell"]


  connect() {
    const button = document.querySelector(".fa-envelope")
    button.addEventListener("click", this.#actionClick)

    message = window.localStorage.getItem("message")
    console.log(message);
    
    if(message == 1) {this.bellTarget.classList.remove("d-none") }
    console.log("Notification controller - Connected")
    createConsumer().subscriptions.create(
      { channel: "NotificationChannel", id: this.userIdValue },
      { received: data => {
        console.log(data);
        this.bellTarget.classList.remove("d-none")
        window.localStorage.setItem("message", data)
    } }
    )
    console.log(window.localStorage.getItem("message"));

  }
  #actionClick() {
    console.log("click")
    window.localStorage.setItem("message", 0)
  }
}
