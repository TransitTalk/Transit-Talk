import {Controller} from "stimulus"

export default class extends Controller {
  static targets = [ 'button', 'fragment' ];

  select(event) {
    this.buttonTargets.forEach(el => el.classList.toggle("selected", false));
    event.target.classList.toggle('selected', true);
    this.fragmentTargets.forEach(el => {
      el.style.display = event.target.dataset.toShow === el.id ? 'block' : 'none';
    });
  }
}
