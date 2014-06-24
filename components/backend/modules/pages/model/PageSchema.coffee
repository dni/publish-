mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports = mongoose.model 'Page', new Schema
  user: String
  number: Number
  title: String
  magazine: String
  article: String
  layout: String
  published: Boolean