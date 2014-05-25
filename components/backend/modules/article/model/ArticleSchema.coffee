mongoose = require 'mongoose/'
Schema = mongoose.Schema

module.exports = mongoose.model 'Article', new Schema
  user: String
  title: String
  author: String
  desc: String
  teaser: String
  date: Date
  published: Boolean
  category: String
  tags: String
  files: Object