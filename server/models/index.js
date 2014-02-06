var mongoose = require('mongoose/'),
	db = mongoose.connect('mongodb://localhost/publish'),
	Schema = mongoose.Schema;

var UserSchema = new Schema({
  name: String,
  email: String,
  username: String,
  password: String
});


var ArticleSchema = new Schema({
  title: String,
  author: String,
  desc: String,
  date: Date,
  privatecode: Boolean,
  images: {
      type: Array,
      'default': []
    }
});


var MagazineSchema = new Schema({
  title: String,
  editorial: String,
  impressum: String,
  cover: String,
  back: String,
  pages: Object,
  date: Date
});


module.exports.Magazine = mongoose.model('Magazine', MagazineSchema); 
module.exports.Article = mongoose.model('Article', ArticleSchema); 
module.exports.User = mongoose.model('User', UserSchema); 