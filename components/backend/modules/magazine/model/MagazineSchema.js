var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;


var MagazineSchema = new Schema({
  title: String,
  author: String,
  desc: String,
  editorial: String,
  impressum: String,
  published: Boolean,
  orientation: String,
  papersize: String,
  date: Date
});


module.exports.Magazine = mongoose.model('Magazine', MagazineSchema);