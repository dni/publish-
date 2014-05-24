mongoose = require 'mongoose'
Schema = mongoose.Schema

module.exports = mongoose.model "Message", new Schema
  date: Date
  type: String
  message: String
  additionalinfo: Object
  username: String