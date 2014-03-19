var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;


var fileSchema = new Schema({
  name: String,
  link: String,
  type: String,
  info: String,
  alt: String,
  desc: String,
  relation: String,
  parent: String,
  key: String
});

module.exports.File = mongoose.model('File', fileSchema);