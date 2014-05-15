module.exports = (grunt)->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    #clean
    clean:
      build:
        src: [ 'cache/build' ]

    # bower
    bower:
      install:
        option:
          targetDir: 'bower_components'

    # forever
    forever:
      dev:
        options:
          command: 'coffee'
          index: 'server.coffee'
          logDir: 'cache'

      dist:
        options:
          index: 'app.js',
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
          "tinymce.js": "tinymce/tinymce.min.js"
          "jquery.tinymce.js": "tinymce/jquery.tinymce.min.js"
          "jquery.form.js": "jquery-form/jquery.form.js"
          "underscore.js": "underscore-amd/underscore.js"
          "wreqr.js": "backbone.wreqr/lib/amd/backbone.wreqr.js"
          "babysitter.js": "backbone.babysitter/lib/backbone.babysitter.js"
          "backbone.js": "backbone-amd/backbone.js"
          "bootstrap.js": "bootstrap/dist/js/bootstrap.js"
          "marionette.js": "marionette/lib/core/amd/backbone.marionette.js"
          "localstorage.js": "backbone-localstorage/backbone-localstorage.js"
          "text.js": 'requirejs-text/text.js'
          "tpl.js": 'requirejs-tpl/tpl.js'
          "cs.js": 'require-cs/cs.js'
          "i18n.js": 'requirejs-i18n/i18n.js'
          "coffee-script.js": 'coffee-script/index.js'
          "d3.js": 'd3/d3.js'
          "minicolors.js": 'jquery-minicolors/jquery.minicolors.js'
          # Folders
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

      components:
        options:
          destPrefix: "cache/build"
        files:
          # Make dependencies follow your naming conventions
          "components": "../components"

      requirejs:
        dev:
          compile:
            options:
              mainConfigFile: "components/backend/build.js",
              name: "main",
              out: "optimized.js"




  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-bowercopy'
  grunt.loadNpmTasks 'grunt-forever'

  grunt.registerTask 'dev', 'Prepare for Development', [
    'bowercopy:libsBackend'
    'bowercopy:libsFrontend'
    'forever:dev:start'
  ]

  grunt.registerTask 'restart', 'Restart forever Server', [
    'forever:dev:restart'
    'forever:dist:restart'
  ]

  grunt.registerTask 'build', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean',
    'requirejs'
    'forever:dist:start'
  ]

  return grunt