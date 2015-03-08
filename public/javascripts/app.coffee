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
		estas
		.getCerca(scope.ubicacion.coorx,scope.ubicacion.coory)
		.then (data) ->
			scope.cercanos = data
			console.log(scope.cercanos)


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
