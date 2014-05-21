mongoose = require('mongoose/')
Schema = mongoose.Schema

module.exports = mongoose.model 'Setting', new Schema
  name: String
  settings:
    type: Object
    'default': {}
