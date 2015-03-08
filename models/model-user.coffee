mongoose 	= require('./models')
Schema 		= mongoose.Schema

userSchema = new Schema 
		correo: String
		username: String
		password: String
		favoritos: []

	
module.exports = mongoose.model 'user', userSchema