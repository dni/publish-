var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;


var fileSchema = new Schema({
  name: String,
  link: String,
  type: String
});


module.exports.File = mongoose.model('File', fileSchema);