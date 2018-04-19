$(document).ready(function()
{
	//this code is for sorting DOM elements by id or name
	jQuery.fn.sortDomElements = function(comparator) {
		return Array.prototype.sort.call(this, comparator).each(function(i) {
			this.parentNode.appendChild(this);
		});
	};

	// Function to compare two numbers or strings: akey and bkey
	function comparePair(akey,bkey) {
		if (akey == bkey) return 0;
		if (akey < bkey) return -1;
		if (akey > bkey) return 1;
	}

	/* Function to sort DOM elements in a hierachical tree structure where: 
	parentSelector is a jquery selector that specifies the top DOM element in a tree
	whose children elements are desired to be sorted.
	childSelector is a jquery selector that selects all children DOM elements of the tree
	that we want to be sorted
	id is an number parameter that specifies whether to use a simple comparison function
	for sorting  (id=0 is default) or use a more customized script for complex comparisons 
	(id=1). In this case, the complex comparisons involve strings, empty strings, and numbers 
	for line titles.*/
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
	
	/* Function for a clicking event that will sort DOM elements in a hierachical tree structure,
	remove active class from specified html buttons, and attach an active class on the html button 
	clicked on.
	buttonId is a jquery selector for the id that belongs to the html button on the index page that 
	will call the sortLineDOM function.
	parentSelector, childSelector, and id are all parameters used for the sortLineDom function 	*/
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