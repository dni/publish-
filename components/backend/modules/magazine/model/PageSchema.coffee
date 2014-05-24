mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports = mongoose.model 'Page', new Schema
  number: Number
  magazine: String
  article: String
  layout: String