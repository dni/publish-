module.exports = (grunt)->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    #clean
    clean:
      build: src: [ 'cache/build' ]
      vendorFrontend: src: [ 'components/backend/vendor' ]
      vendorBackend: src: [ 'components/frontend/vendor' ]

    # bower
    bower:
      install:
        option:
          targetDir: 'bower_components'

    # forever
    forever:
      options:
        command: 'coffee'
        index: 'server.coffee'
        logDir: 'cache'


    bowercopy:
      options:
        # Bower components folder will be removed afterwards
        clean: true

      # Javascript
      libsBackend:
        options:
          destPrefix: "components/backend/vendor"
        files:
          "io.js": "socket.io-client/dist/socket.io.js"
          "jquery.js": "jquery/dist/jquery.js"
          "require.js": "requirejs/require.js"
          "jquery.ui.js": "jquery-ui/ui/jquery-ui.js"
          "jquery.tinymce.js": "tinymce/jquery.tinymce.min.js"
          "jquery.form.js": "jquery-form/jquery.form.js"
          "underscore.js": "underscore-amd/underscore.js"
          "wreqr.js": "backbone.wreqr/lib/amd/backbone.wreqr.js"
          "babysitter.js": "backbone.babysitter/lib/backbone.babysitter.js"
          "backbone.js": "backbone-amd/backbone.js"
          "marionette.js": "marionette/lib/core/amd/backbone.marionette.js"
          "localstorage.js": "backbone-localstorage/backbone-localstorage.js"
          "text.js": 'requirejs-text/text.js'
          "tpl.js": 'requirejs-tpl/tpl.js'
          "cs.js": 'require-cs/cs.js'
          "i18n.js": 'requirejs-i18n/i18n.js'
          "coffee-script.js": 'coffee-script/index.js'
          "d3.js": 'd3/d3.js'
          # Folders
          "tinymce": "tinymce"
          "minicolors": 'jquery-minicolors'
          "fancybox": "fancybox/source",
          "bootstrap": "bootstrap",
          "require-less": 'require-less'

      libsFrontend:
        options:
          destPrefix: "components/frontend/vendor"
        files:
          "jquery.js": "jquery/dist/jquery.js",
          "require.js": "requirejs/require.js",
          "backbone.js": "backbone-amd/backbone.js",
          "marionette.js": "marionette/lib/core/amd/backbone.marionette.js",
          "babysitter.js": "backbone.babysitter/lib/backbone.babysitter.js",
          "wreqr.js": "backbone.wreqr/lib/amd/backbone.wreqr.js",
          "coffee-script.js": 'coffee-script/index.js',
          "underscore.js": 'underscore-amd/underscore.js'
          "text.js": 'requirejs-text/text.js'
          "tpl.js": 'requirejs-tpl/tpl.js'
          "cs.js": 'require-cs/cs.js'
          "i18n.js": 'requirejs-i18n/i18n.js'
          # Folders
          "fancybox": "fancybox/source",
          "bootstrap": "bootstrap",
          "require-less": 'require-less'


    requirejs:
      compile:
        options:
          appDir: 'components/backend/'
          mainConfigFile: "components/backend/config.js"
          dir: "cache/build"
          #out: "optimized.js"

          stubModules: ['cs']
          # modules: [{
          #name: "main"
            # exclude: ['coffee-script']
          # }]


  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-bowercopy'
  grunt.loadNpmTasks 'grunt-forever'

  grunt.registerTask 'dev', 'Prepare for Development', [
    'bowercopy:libsBackend'
    'bowercopy:libsFrontend'
    'forever:start'
  ]

  grunt.registerTask 'restart', 'Restart forever Server', [
    'forever:restart'
  ]

  grunt.registerTask 'build', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean:build'
    'bowercopy:libsBackend'
    'bowercopy:libsFrontend'
    'requirejs'
    #'forever:dist:start'
  ]

  return grunt