var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var SettingSchema = new Schema({
  name: String,
  settings: {
      type: Array,
      'default': []
    }
});

module.exports.Setting = mongoose.model('Setting', SettingSchema); 
