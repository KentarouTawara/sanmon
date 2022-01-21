import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  greet() {
    const menu = document.getElementById("hanbager");
    menu.classList.toggle("hidden");
  }
}