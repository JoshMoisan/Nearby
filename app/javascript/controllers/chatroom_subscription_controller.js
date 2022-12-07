import { Controller } from "@hotwired/stimulus"
import { createConsumer } from "@rails/actioncable"

export default class extends Controller {
  static values = { chatroomId: Number }
  static targets = ["messages"]

  connect() {
    console.log(`Subscribe to the chatroom with the id ${this.chatroomIdValue}.`)
    console.log(this.messagesTarget)
    createConsumer().subscriptions.create(
      { channel: "ChatroomChannel", id: this.chatroomIdValue },
      { received: data => { this.#insertMessage(data) } }
    )
  }

  resetForm(event) {
    event.preventDefault()
    const form = event.target
    form.reset()
  }

  #insertMessage(data) {
    this.messagesTarget.insertAdjacentHTML("beforeend", data)
    // this.messagesTarget.scrollTo(0, this.messagesTarget.scrollHeight)
    window.scrollTo(0 , document.body.scrollHeight)
  }
}
