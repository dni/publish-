mongoose = require 'mongoose'
Schema = mongoose.Schema
collections = {}

module.exports = (dbTable)->
  unless collections[dbTable]?
    collections[dbTable] = mongoose.model dbTable, new Schema
      modelName : String
      user: String
      crdate: Date
      date: Date
      attributes: {}

  collections[dbTable]
