// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require turbolinks
//= require react_ujs
//= require components
//= require ckeditor/init
//= require_tree .

$ = jQuery = require('jquery');
//= require jquery_ujs



$(document).ready(function() {
  // TODO: Fix close-div button
	// Close-div button in alerts
	$(".close-div").click(function() {
		console.log("close-div");
		$(this).parent().animate({'opacity': '0'}, 300);
	});

  $(".alert").animate({'top': '0rem'}, 500).delay(2000).animate({
    'top': '-3rem'
  }, 200);


  $(".lesson>.lesson-videos").hide();
  $(".lesson.active>.lesson-videos").show();

  var ready = function() {
  var mapOptions = {
    center: { lat: 52.397036, lng: 16.965626},
    zoom: 14,
    scrollwheel: false,
    zIndex: 1
  };
  var map = new google.maps.Map(document.getElementById('map-canvas'),
      mapOptions);

  var marker = new google.maps.Marker({
    position: { lat: 52.397874, lng: 16.951722},
    map: map,
    title: 'Hello World!'
  });

  console.log('ready-app');
};

});
