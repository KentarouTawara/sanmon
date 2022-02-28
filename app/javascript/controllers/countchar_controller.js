import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "title", "content", "title_counter", "content_counter" ]

  // contentを数える
  countContentCharacters(event) {
    const characters = this.contentTarget.value.length;
    this.content_counterTarget.innerText = characters;
    if (characters < 100 || characters > 200) {
      this.content_counterTarget.style.color = "red";
    } else {
      this.content_counterTarget.style.color = "green";
    }
  }

  countTitleCharacters(event) {
    const characters = this.titleTarget.value.length;
    this.title_counterTarget.innerText = characters;
    if (characters > 30) {
      this.title_counterTarget.style.color = "red";
    } else {
      this.title_counterTarget.style.color = "green";
    }
  }
}