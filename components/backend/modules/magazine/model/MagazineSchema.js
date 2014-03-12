var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;


var MagazineSchema = new Schema({
  title: String,
  author: String,
  desc: String,
  editorial: String,
  impressum: String,
  published: Boolean,
  cover: String,
  back: String,
  pages: Array,
  date: Date
});


module.exports.Magazine = mongoose.model('Magazine', MagazineSchema);