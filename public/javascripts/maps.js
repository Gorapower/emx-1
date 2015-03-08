//19.351416,-99.181786

var lat = 19.351416;
var lon = -99.181786;
window.navigator.geolocation.getCurrentPosition(function(lo){ 
     lat = lo.coords.latitude;
     lon = lo.coords.longitude;
});

function initialize() {

  setTimeout(function(){ 
      var mapOptions = {
      zoom: 15,
      center: new google.maps.LatLng(lat, lon)
    };
    var map = new google.maps.Map(document.getElementById('map-canvas'),
        mapOptions);

    var marker = new google.maps.Marker({
        position: new google.maps.LatLng(lat,lon),
        map: map,
        title: 'Aqui estas!'
    });
  }, 2000); 

}

google.maps.event.addDomListener(window, 'load', initialize);
