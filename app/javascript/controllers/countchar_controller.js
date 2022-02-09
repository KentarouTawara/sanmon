import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "name", "counter" ]

  countCharacters(event) {
    const characters = this.nameTarget.value.length;
    this.counterTarget.innerText = characters;
    if (characters < 100 || characters > 200) {
      this.counterTarget.style.color = "red";
    } else {
      this.counterTarget.style.color = "green";
    }
  }
}