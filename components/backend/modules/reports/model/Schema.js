var mongoose = require('mongoose/'),
	Schema = mongoose.Schema,
	modelName = "Report";

var modelSchema = new Schema({
	date: Date,
	data: {}
});

module.exports[modelName] = mongoose.model(modelName, modelSchema);