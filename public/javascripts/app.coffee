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

	scope.estac = {}
	scope.cuadro = false

	scope.setEs = (id) ->
		estas
		.getEsta(id)
		.then (data) ->
			console.log (data)
			scope.estac = data.data
			scope.estac.disponibilidad = Math.floor (Math.random() * 4  )+ 1
			scope.cuadro = true

	scope.obtener_cercanos = () ->		
		g = 0

		scope.initialize = () ->
		  
		  	mapOptions = 
			    zoom: 13
			    center: new (google.maps.LatLng)(19.4325504,-99.13379309999999)

			  map = new (google.maps.Map)(document.getElementById('map-canvas'), mapOptions)

			  mark = new (google.maps.Marker)(
			      position: new google.maps.LatLng 19.4325504,-99.13379309999999
			      map: map
			      title: 'Aqui estas!')

			  
			  x1 = parseFloat scope.cercanos.data[1].XCOORD
			  y1 = parseFloat scope.cercanos.data[1].YCOORD

			  scope.mark1 = new (google.maps.Marker)(
			      position: new google.maps.LatLng y1,x1
			      map: map
			      title: scope.cercanos.data[1]._id+'')
			  x2 = parseFloat scope.cercanos.data[2].XCOORD
			  y2 = parseFloat scope.cercanos.data[2].YCOORD

			  scope.mark2 = new (google.maps.Marker)(
			      position: new google.maps.LatLng y2,x2
			      map: map
			      title: scope.cercanos.data[2]._id+'')
			  x3 = parseFloat scope.cercanos.data[3].XCOORD
			  y3 = parseFloat scope.cercanos.data[3].YCOORD

			  scope.mark3 = new (google.maps.Marker)(
			      position: new google.maps.LatLng y3,x3
			      map: map
			      title: scope.cercanos.data[3]._id+'')
			  x4 = parseFloat scope.cercanos.data[4].XCOORD
			  y4 = parseFloat scope.cercanos.data[4].YCOORD

			  scope.mark4 = new (google.maps.Marker)(
			      position: new google.maps.LatLng y4,x4
			      map: map
			      title: scope.cercanos.data[4]._id+'')
			  x5 = parseFloat scope.cercanos.data[5].XCOORD
			  y5 = parseFloat scope.cercanos.data[5].YCOORD

			  scope.mark5 = new (google.maps.Marker)(
			      position: new google.maps.LatLng y5,x5
			      map: map
			      title: scope.cercanos.data[5]._id+'')

			  google.maps.event.addListener scope.mark1,'click', () ->
				  #map.setZoom(12);
				  map.setCenter(scope.mark1.getPosition());
				  #alert(scope.mark1.getTitle())
				  scope.setEs(scope.mark1.getTitle())
				  return

					google.maps.event.addListener scope.mark2,'click', () ->
					  #map.setZoom(12);
					  map.setCenter(scope.mark2.getPosition());
					  #alert(scope.mark2.getTitle())
				  	scope.setEs(scope.mark2.getTitle())

					  return

					google.maps.event.addListener scope.mark3,'click', () ->
					  #map.setZoom(12);
					  map.setCenter(scope.mark3.getPosition());
					  #alert(scope.mark3.getTitle())
				  	scope.setEs(scope.mark3.getTitle())
					  return

					google.maps.event.addListener scope.mark4,'click', () ->
					  #map.setZoom(12);
					  map.setCenter(scope.mark4.getPosition());
					  #alert(scope.mark4.getTitle())
				  	scope.setEs(scope.mark4.getTitle())
					  return

				  google.maps.event.addListener scope.mark5,'click', () ->
					  #map.setZoom(12);
					  map.setCenter(scope.mark5.getPosition());
					  #alert(scope.mark5.getTitle())
				  	scope.setEs(scope.mark5.getTitle())
				  	return
							 
			  return
		  
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
