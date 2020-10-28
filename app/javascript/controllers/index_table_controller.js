import { Controller } from "stimulus";

const Turbolinks = require("turbolinks");

export default class extends Controller {
  visit(event) {
    if (event.target === event.currentTarget) {
      Turbolinks.visit(this.data.get("link"));
    }
  }
}
