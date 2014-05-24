mongoose = require 'mongoose/'
Schema = mongoose.Schema

module.exports = mongoose.model 'User', new Schema
  name: String
  username: String
  role: String
  password: String
  email: String
