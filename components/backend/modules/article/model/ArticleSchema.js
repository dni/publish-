var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

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

module.exports.Article = mongoose.model('Article', ArticleSchema); 
