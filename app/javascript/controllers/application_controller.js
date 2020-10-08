import { Controller } from "stimulus";

export default class extends Controller {
  // eslint-disable-next-line class-methods-use-this
  connect() {
    $('[data-toggle="tooltip"]').tooltip();
  }
}
