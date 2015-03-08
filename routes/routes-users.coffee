users = require '../models/model-user'
module.exports = (router) ->

	router

	.get '/user/:user', (req,res) ->
		user = req.param('user')
		res.render('home',{user:user})

	.get '/api/user', (req,res) ->
		users
		.find {}
		.exec (err, data) ->
			if err
				res.send err
			res.send data

	.get '/api/user/:username', (req,res) ->
		users
		.findOne {
			username: req.param('username')
		}
		.exec (err, data) ->
			if err
				res.send err
			res.send data

	.post '/api/user', (req,res) ->
		newUser = users {
			correo: req.body.correo
			username: req.body.username
			password: req.body.password			
		}

		newUser.save (err,doc,num)->
			if err
				res.send err
			else
				console.log(doc)
				res.redirect '/user/'+req.body.username