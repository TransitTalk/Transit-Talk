$(document).ready(function()
{
	//this code is for sorting DOM elements by id or name
	jQuery.fn.sortDomElements = function(comparator) {
		return Array.prototype.sort.call(this, comparator).each(function(i) {
			this.parentNode.appendChild(this);
		});
	};

	function comparePair(akey,bkey) {
		if (akey == bkey) return 0;
		if (akey < bkey) return -1;
		if (akey > bkey) return 1;
	}

	function sortLineDom(parentSelector, childSelectorCompare, id=0) {
		$(parentSelector).sortDomElements(function(a,b){
			akey = $(a).children(childSelectorCompare).text();
			bkey = $(b).children(childSelectorCompare).text();
			if (id == 0){
				return comparePair(akey,bkey);
			} else {
				//check if values are integer or string or empty string
				akeyRegex = /[a-zA-Z]./.test(akey); //checks values in the form of X94, but not 52A
				bkeyRegex = /[a-zA-Z]./.test(bkey);
				aint = parseInt(akey)? parseInt(akey) : (akeyRegex)? 0.2:0;
				bint = parseInt(bkey)? parseInt(bkey) : (bkeyRegex)? 0.2:0;
				//Case to sort when both values are non-empty strings
				if(akeyRegex && bkeyRegex){
					aint = akey;
					bint = bkey;
				}
				return comparePair(aint, bint)
			}
		});
	};

	function clickSort(buttonId, parentSelector, childSelectorCompare, id=0) {
		$(buttonId).click( function () {
			$("#sort-name, #sort-id").removeClass('active');
			sortLineDom(parentSelector, childSelectorCompare, id);
			$(this).addClass('active');
		});

	};

	clickSort("#sort-name", ".page-container .stop-partial", "span");
	clickSort("#sort-id", ".page-container .stop-partial", ".line-tile", 1);
});