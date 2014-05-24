mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports = mongoose.model 'Magazine', new Schema
  user: String
  title: String
  author: String
  desc: String
  editorial: String
  impressum: String
  published: Boolean
  orientation: String
  papersize: String
  date: Date
  info: String
  product_id: String