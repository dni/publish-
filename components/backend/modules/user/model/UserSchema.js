var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var UserSchema = new Schema({
  name: String,
  role: String,
  password: String,

});

module.exports.User = mongoose.model('User', UserSchema);
