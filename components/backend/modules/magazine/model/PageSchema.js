var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;


var PageSchema = new Schema({
  number: Number,
  magazine: String,
  article: String,
  layout: String,
});

module.exports = mongoose.model('Page', PageSchema);
