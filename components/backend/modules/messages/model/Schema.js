var mongoose = require('mongoose/'),
	Schema = mongoose.Schema,
	modelName = "Message";

var modelSchema = new Schema({
	date: Date,
	type: String,
	title: String,
	username: String
});

module.exports[modelName] = mongoose.model(modelName, modelSchema);