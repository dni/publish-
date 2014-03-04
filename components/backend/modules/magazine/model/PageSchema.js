var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;


var PageSchema = new Schema({
  number: Number,
  article: String,
  layout: String,
});


module.exports.Magazine = mongoose.model('Page', PageSchema);