// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function()
{
	$("header .hamburger").click(function()
	{
		$(".side-menu").animate({"left": '0%'});
		$(".side-menu-overlay").fadeIn();
	});

	$(".side-menu-overlay").click(function()
	{
		$(".side-menu").animate({"left": '-85%'});
		$(".side-menu-overlay").fadeOut();
	});

	$("header .search").click(function()
	{
		$(".overlay-search").fadeIn();
		$(".overlay-search input[type='text']").val(""); // clear the value
		$(".overlay-search input[type='text']").focus();
	});

	$(".overlay-search").click(function()
	{
		$(".overlay-search").fadeOut();
	});

	$(".overlay-search *").click(function(event)
	{
		event.stopPropagation();
	});

	$(".new-issue-line").change(function()
	{
		var self = this;

		$.ajax({
		  url: "/lines/" + $(this).val() + "/get_stops",
		  context: document.body
		}).done(function(value) {
			// Populate the select with values
			$(".new-issue-stops option").remove();
			$(value).each(function(i, value)
			{
				$(".new-issue-stops").append('<option value="' + value[0] + '">' + value[1] + '</option>');
			});
		});
	});
});
