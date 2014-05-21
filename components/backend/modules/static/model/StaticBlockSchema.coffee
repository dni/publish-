mongoose = require 'mongoose/'
Schema = mongoose.Schema

module.exports = mongoose.model 'StaticBlock', new Schema
  key: String
  data: String
  deleteable: Boolean
