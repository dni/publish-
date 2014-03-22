var mongoose = require('mongoose/'),
	Schema = mongoose.Schema;

var SettingSchema = new Schema({
  name: String,
  settings: {
      type: Object,
      'default': {}
    }
});

module.exports = mongoose.model('Setting', SettingSchema);
