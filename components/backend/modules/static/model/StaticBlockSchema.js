var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var StaticBlockSchema = new Schema({
  key: String,
  data: String
});

module.exports.StaticBlock = mongoose.model('StaticBlock', StaticBlockSchema);
