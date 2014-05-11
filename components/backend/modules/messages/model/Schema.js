var mongoose = require('mongoose/'),
	Schema = mongoose.Schema

var modelSchema = new Schema({
	date: Date,
	type: String,
	message: String,
	additionalinfo: Object,
	username: String
});

module.exports = mongoose.model("Message", modelSchema);