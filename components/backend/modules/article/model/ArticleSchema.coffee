mongoose = require 'mongoose/'
Schema = mongoose.Schema

module.exports = mongoose.model 'Article', new Schema
  user: String
  title: String
  author: String
  desc: String
  date: Date
  privatecode: Boolean
  category: String
  tags: String
  files: Object