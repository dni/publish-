var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var StaticBlockSchema = new Schema({
  key: String,
  data: String,
  deleteable: Boolean
});

module.exports = mongoose.model('StaticBlock', StaticBlockSchema);
