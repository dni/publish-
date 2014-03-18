var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var StaticBlockSchema = new Schema({
  key: String,
  data: String,
  deleteable: Boolean
});

module.exports.StaticBlock = mongoose.model('StaticBlock', StaticBlockSchema);
