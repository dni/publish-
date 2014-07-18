fs = require("fs-extra")
auth = require './../../utilities/auth'

module.exports.setup = (app, config) ->
  Page = require("../../model/Schema")(config.dbTable);