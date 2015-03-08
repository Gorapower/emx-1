//19.351416,-99.181786
var g = 10;

function initialize() {
  var mapOptions = {
    zoom: 15,
    center: new google.maps.LatLng(19.351416,-99.181786)
  };

  var map = new google.maps.Map(document.getElementById('map-canvas'),
    mapOptions);

  var marker = new google.maps.Marker({
      position: new google.maps.LatLng(19.351416,-99.181786),
      map: map,
      title: 'Aqui estas!'
  });
  for(var i=0;i<g;i++)
  {
    var marker = new google.maps.Marker({
        position: new google.maps.LatLng( (19.381416 + (i*0.0001) ), (-99.121786 + (i*0.0001)) ),
        map: map,
        title: 'Aqui estas!'
    });
  }
}

google.maps.event.addDomListener(window, 'load', initialize);



/*
initialize = ->
  mapOptions = 
    zoom: 16
    center: new (google.maps.LatLng)(19.351416, -99.181786)
  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)
  marker = new (google.maps.Marker)(
    position: new (google.maps.LatLng)(19.351416, -99.181786)
    map: map
    title: 'Aqui estas!')
  return

google.maps.event.addDomListener window, 'load', initialize

*/