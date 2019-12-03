import {Controller} from "stimulus"

export default class extends Controller {
  static targets = [ 'button' ];

  favorite(event) {
	  event.stopPropagation();
  }

  unfavorite(event) {
	  event.stopPropagation();
  }
}
