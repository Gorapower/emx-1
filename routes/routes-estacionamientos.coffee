request = require('request')
qs 		= require('query-string')
gl		= require('geolib')
estacionamientos = require('../models/model-estacionamiento')
module.exports = (router) -> 

	url = 'http://datos.labcd.mx/api/action/datastore_search'
	data =
		resource_id : '4366bf30-01eb-4fa0-9f2a-c74153ec2b79'



	router
	.get '/api/estacionamiento/:id' , (req,res)->

		id_estacionamiento = req.param('id')+""
		if id_estacionamiento.length > 4
			res.send('error')

		id_estacionamiento = parseInt(id_estacionamiento)
		if id_estacionamiento > 22000
			res.send('error')
		request url+'_sql?sql=SELECT%20*%20from%20"4366bf30-01eb-4fa0-9f2a-c74153ec2b79"%20WHERE%20_id='+id_estacionamiento,  (error,response,body) ->
			if !error and response.statusCode == 200
				api_cd = JSON.parse(body)
				record = api_cd.result.records[0]
				console.log(record)
				estacionamientos
				.findOne {id_estacionamiento: record._id}
				.exec (err,info) ->
						if err  
							handleError(err)
							res.send(err)
						if info == null
							res.send('error')
						else
							data =
								id_estacionamiento: record._id
								precio: info.precio
								rating: info.rating
								disponibilidad: info.disponibilidad
								coory: record.YCOORD
								coorx: record.XCOORD

							res.send(data)
						return

			else
				res.send(error)

			return	


	.post '/api/cercanos', (req,res) ->
		console.log(req.body)
		xcoor = req.body.xcoord
		ycoor = req.body.ycoord

		xcoor = parseFloat xcoor
		ycoor = parseFloat ycoor
		console.log(ycoor)
		request url+'_sql?sql=SELECT%20*%20from%20"4366bf30-01eb-4fa0-9f2a-c74153ec2b79"',  (error,response,body) ->

			if !error and response.statusCode == 200		
				api_cd = JSON.parse(body)
				cercanos = []
				check_distance = (i) ->
					record = api_cd.result.records[i]
					distance = gl.getDistance {
						latitude: ycoor
						longitude: xcoor
						}, {
							latitude: parseFloat record.YCOORD
							longitude: parseFloat record.XCOORD
						}
					distance = parseInt distance
					if(distance < 500)
						cercanos.push(record)
						console.log(distance)
				for num in [1..2127]
					check_distance(num)

				res.send(cercanos)
			else
				res.send(err)

	###
	.get '/first_five',(req,res) ->
		query = qs.stringify {
			resource_id: '4366bf30-01eb-4fa0-9f2a-c74153ec2b79'
			limit: 5
		}		
		
		
		request url+'?'+query, (error,response,body) ->
			if !error and response.statusCode == 200
				data = JSON.parse(body)
				res.render('index',{data: data.result.records[0]})
			else
				res.send(error)
			return

		return
	###

	###		
	.get '/api/llenar/:id', (req,res) ->
		
		id = req.param('id')
		id = parseInt(id)
		if id > 2128
			res.send('terminado')
		else
			nuevo = new estacionamientos {
				id_estacionamiento: id
				precio: Math.floor (Math.random() * 50) + 1 
				rating: Math.floor (Math.random() * 5) + 1
				disponibilidad: '#e53935' 
			}
			nuevo.save (e)->
				id += 1
				res.redirect '/api/llenar/'+id
	###
	###.get '/api/cercanos', (req,res) ->
				
			xcoor = req.body.xcoor
			ycoor = req.body.ycoor 
			cercanos = []

			check_distance = (i) ->
				
				distance = gl.getDistance {
					latitude: 
					longitude: -99.181590
					}, {
						latitude: parseFloat record.YCOORD
						longitude: parseFloat record.XCOORD
					}
				distance = parseInt distance
				if(distance < 500)
					cercanos.push(record._id)
					console.log(distance)

			for num in [1..2127]
				check_distance(num)

			res.send(cercanos)###