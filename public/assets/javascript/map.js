var map;
var infoWindow;
var service;
function initialize() {
  map = new google.maps.Map(document.getElementById('map-canvas'), {
    center: new google.maps.LatLng(38.884739, -76.994183),
    zoom: 13,
    styles: [
      {
        stylers: [
          { visibility: 'simplified' }
        ]
      },
      {
        elementType: 'labels',
        stylers: [
          { visibility: 'off' }
        ]
      }
    ]
  });
  infoWindow = new google.maps.InfoWindow();
  service = new google.maps.places.PlacesService(map);
  google.maps.event.addListenerOnce(map, 'bounds_changed', performSearch);
}
function performSearch() {
  var request = {
    bounds: map.getBounds(),
    keyword: 'pets'
  };
  service.radarSearch(request, callback);
}
function callback(results, status) {
  if (status != google.maps.places.PlacesServiceStatus.OK) {
    alert(status);
    return;
  }
  for (var i = 0, result; result = results[i]; i++) {
    createMarker(result);
  }
}
function createMarker(place) {
  var marker = new google.maps.Marker({
    map: map,
    position: place.geometry.location,
    icon: {
      // Star
      path: 'M 0,-24 6,-7 24,-7 10,4 15,21 0,11 -15,21 -10,4 -24,-7 -6,-7 z',
      fillColor: '#BF0000',
      fillOpacity: 1,
      scale: 1/4,
      strokeColor: '#000000',
      strokeWeight: .5
    }
  });
  google.maps.event.addListener(marker, 'click', function() {
    service.getDetails(place, function(result, status) {
      if (status != google.maps.places.PlacesServiceStatus.OK) {
        alert(status);
        return;
      }
      infoWindow.setContent(result.name);
      infoWindow.open(map, marker);
    });
  });
}
google.maps.event.addDomListener(window, 'load', initialize);
