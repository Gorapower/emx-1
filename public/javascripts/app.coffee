app = angular.module 'app',[]

homeController = (scope,window) ->
	scope.login = () ->
		console.log("login")
		window.location.href = '/login'
		return
	scope.signup = () ->
		console.log("signup")
		window.location.href  = '/signup'
		return

userController = (scope, window, users, estas) ->
	console.log('hola')
	scope.id = 1
	scope.disponibilidad = "#000"
	scope.ubicacion = {}
	scope.cercanos = []

	window.navigator
	.geolocation.getCurrentPosition (position) ->
		scope.ubicacion.coory = position.coords.latitude 

	window.navigator
	.geolocation.getCurrentPosition (position) ->
		scope.ubicacion.coorx = position.coords.longitude 	

	scope.obtener_cercanos = () ->		
		g = 0

		scope.initialize = () ->
		  setTimeout() ->
		  	mapOptions = 
			    zoom: 15
			    center: new (google.maps.LatLng)(19.351416, -99.181786)

			  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)

			  mark = new (google.maps.Marker)(
			      position: new google.maps.LatLng 19.351416,-99.181786
			      map: map
			      title: 'Aqui estas!')

			  i = 0
			  while i < g

			    mark = new (google.maps.Marker)(
			      position: new google.maps.LatLng parseFloat scope.cercanos.data[i].YCOORD, parseFloat scope.cercanos.data[i].XCOORD
			      map: map
			      title: 'Aqui estas!')
			   
			    i++
			  return

		  , 2000;
		  
		estas
		.getCerca(scope.ubicacion.coorx,scope.ubicacion.coory)
		.then (data) ->
			scope.cercanos = data
			console.log(scope.cercanos.data.length)			
			g = parseInt scope.cercanos.data.length
			google.maps.event.addDomListener window, 'load', scope.initialize()


getUser = (http) ->
	userService = {}
	userService.getUser = () ->
		return http {
			method: 'GET'
			url: '/api/user/'
		}
	return userService

getEsta = (http,window) ->
	estaService = {}

	estaService.getEsta = (id) ->
		return http {
			method: 'GET'
			url: '/api/estacionamiento/'+id
		}
	estaService.getCerca = (coorx, coory) ->
		console.log(coorx)
		return http {
			method: 'POST'
			url: '/api/cercanos'
			data:{
				saludo: 'hola'
				xcoord: coorx
				ycoord: coory
			}	
		}
	return estaService
	
getEsta.$inject = ['$http','$window']
app.factory('service_getEsta', getEsta);

getUser.$inject = ['$http']
app.factory('service_getUser', getUser);	

homeController.$inject = ['$scope','$window']
app.controller('homeCtrl', homeController)

userController.$inject = ['$scope','$window','service_getUser', 'service_getEsta']
app.controller('userCtrl', userController)
