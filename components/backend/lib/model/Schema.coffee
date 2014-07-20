mongoose = require 'mongoose'
Schema = mongoose.Schema
collections = {}

module.exports = (dbTable)->
  console.log dbTable
  unless collections[dbTable]?
    collections[dbTable] = mongoose.model dbTable, new Schema
      sortorder: Number
      user: String
      crdate: Date
      date: Date
      name: String
      fields: Object
  collections[dbTable]
