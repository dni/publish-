module.exports = (grunt)->

  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    #clean
    clean:
      build:
        src: [ 'cache/build' ]


    bowercopy:
      options:
        # Bower components folder will be removed afterwards
        clean: true

      # Javascript
      libsBackend:
        options:
          destPrefix: "components/backend/vendor"

        files:
          "io.js": "socket.io-client/dist/socket.io.js",
          "jquery.js": "jquery/dist/jquery.js",
          "require.js": "requirejs/require.js",
          "jquery.ui.js": "jquery-ui/ui/jquery-ui.js",
          "tinymce.js": "tinymce/js/tinymce/tinymce.js",
          "jquery.form.js": "jquery-form/jquery.form.js",
          "underscore.js": "underscore-amd/underscore.js",
          "wreqr.js": "backbone.wreqr/lib/amd/backbone.wreqr.js",
          "babysitter.js": "backbone.babysitter/lib/backbone.babysitter.js",
          "backbone.js": "backbone-amd/backbone.js",
          "bootstrap.js": "bootstrap/dist/js/bootstrap.js",
          "marionette.js": "marionette/lib/core/amd/backbone.marionette.js",
          "localstorage.js": "backbone-localstorage/backbone-localstorage.js",
          "require-text": 'requirejs-text',
          "require-tpl": 'requirejs-tpl',
          "require-cs": 'require-cs',
          "require-less": 'require-less',
          "require-i18n": 'requirejs-i18n',
          "coffee-script.js": 'coffee-script/index.js',
          "d3.js": 'd3/d3.js',
          "minicolors.js": 'jquery-minicolors/jquery.minicolors.js'

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
          "cs.js": 'require-cs/cs.js',
          "text.js": 'requirejs-text/text.js',
          "require-tpl": 'requirejs-tpl',
          "require-less": 'require-less',
          "require-i18n": 'requirejs-i18n',
          "fancybox": "fancybox/source",
          "bootstrap": "bootstrap",

      components:
        options:
          destPrefix: "cache/build"
        files:
          # Make dependencies follow your naming conventions
          "components": "../components"

      requirejs:
        compile:
          options:
            baseUrl: "./",
            mainConfigFile: "config.js",
            name: "build",
            out: "optimized.js"




  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-bowercopy'

  grunt.registerTask 'dev'
    , 'Prepare for Development'
    , [ 'requirejs' ]
  grunt.registerTask 'build'
    , 'Compiles all of the assets and copies the files to the build directory.'
    , [
      'clean',
      'bowercopy:libsBackend',
      'bowercopy:libsFrontend',
      #'bowercopy:components'
    ]

  return grunt