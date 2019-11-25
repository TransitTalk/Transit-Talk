import {Controller} from "stimulus"

export default class extends Controller {
  static targets = ["content"];

  connect() {
    this.load();
  }

  load() {
    navigator.geolocation.getCurrentPosition((position) => {
        fetch(`/nearby_stops?latitude=${position.coords.latitude}&longitude=${position.coords.longitude}`)
          .then(response => response.text())
          .then(html => this.contentTarget.innerHTML = html)
      },
      (err) => {
        this.contentTarget.innerHTML = err.code === 1 ? 'Cannot find you since Location Services are blocked' :
          `Location hit an error: <i>${err.message}</i>`;
      }
    );
  }
}
