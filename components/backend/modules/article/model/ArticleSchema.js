var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var ArticleSchema = new Schema({
  title: String,
  author: String,
  desc: String,
  date: Date,
  privatecode: Boolean,
  files: Object
});

module.exports.Article = mongoose.model('Article', ArticleSchema);
