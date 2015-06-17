$ = jQuery = require('jquery');

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

  console.log('ready-map');
};

$(document).ready(ready);
$(document).on('page:load', ready);
