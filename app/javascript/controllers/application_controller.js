import { Controller } from "stimulus";

const Turbolinks = require("turbolinks");

export default class extends Controller {
  // eslint-disable-next-line class-methods-use-this
  connect() {
    $('[data-toggle="tooltip"]').tooltip();
    $('[data-toggle="popover"]').popover();

    // eslint-disable-next-line func-names
    $("[data-link]").on("click", function (e) {
      if (e.target === this) {
        Turbolinks.visit($(this).data("link"));
      }
    });
  }
}
