mongoose = require "mongoose"
db = mongoose.connect 'mongodb://localhost/publish'

module.exports = (grunt)->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    clean:
      everything: src: [
        'baker-master'
        'bower_components'
        'lib'
        'node_modules'
        'cache'
        'components/backend/vendor'
        'components/magazine/vendor'
        'components/frontend/vendor'
        'public/files'
        'public/books'
      ]
      reinstall: src: [
        'baker-master'
        'bower_components'
        'lib'
        'cache'
        'components/backend/vendor'
        'components/magazine/vendor'
        'components/frontend/vendor'
        'public/files'
        'public/books'
      ]
      baker: src: [ 'baker-master/books' ]
      lib: src: [ 'lib' ]
      build: src: [ 'cache/build' ]
      buildFrontend: src: [ 'cache/build/frontend' ]
      buildBackend: src: [ 'cache/build/backend' ]
      vendorFrontend: src: [ 'components/backend/vendor' ]
      vendorBackend: src: [ 'components/frontend/vendor' ]
      vendorMagazine: src: [ 'components/magazine/vendor' ]

    mkdir:
      all:
        options:
          create: ['cache', 'public/books', 'public/files', 'baker-master/books']

    bower:
      install:
        option:
          targetDir: 'bower_components'

    gitclone:
      baker:
        options:
          repository: 'https://github.com/bakerframework/baker.git'
          directory: 'baker-master'

    forever:
      server1:
        options:
          command: 'coffee'
          index: 'server.coffee'
          logDir: 'cache'

    bowercopy:
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
          "css": 'require-css'
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
          "css": 'require-css'
          "fancybox": "fancybox/source",
          "bootstrap": "bootstrap",
          "require-less": 'require-less'

      libsMagazine:
        options:
          destPrefix: "components/magazine/js/vendor"
        files:
          "jquery.min.js": "jquery/dist/jquery.min.js",

    copy:
      tinymce:
        cwd: 'components/backend/modules/publish/nls/langs-tinymce'
        src: '*'
        dest: 'components/backend/vendor/tinymce/langs'
        expand: true

    requirejs:
      backend:
        options:
          optimizeAllPluginResources: true
          baseUrl: './components/backend'
          fileExclusionRegExp: /^server/
          paths:
            App: "utilities/App",
            Router: "utilities/Router",
            utils: "utilities/Utilities",
            io: "vendor/io",
            jquery: "vendor/jquery",
            "jquery.ui": "vendor/jquery.ui",
            tinymce: "vendor/tinymce/tinymce.min",
            "jquery.tinymce": "vendor/jquery.tinymce",
            "jquery.form": "vendor/jquery.form",
            underscore: "vendor/underscore",
            wreqr: "vendor/wreqr",
            babysitter: "vendor/babysitter",
            backbone: "vendor/backbone",
            bootstrap: "vendor/bootstrap/dist/js/bootstrap",
            marionette: "vendor/marionette",
            localstorage: "vendor/backbone-localstorage",
            less: 'vendor/require-less/less',
            text: 'vendor/text',
            tpl: 'vendor/tpl',
            cs: 'vendor/cs',
            css: 'vendor/css',
            d3: 'vendor/d3',
            minicolors: 'vendor/minicolors/jquery.minicolors'
          map:
            '*':
              'backbone.wreqr': 'wreqr'
              'backbone.babysitter': 'babysitter'
          packages: [
            {
              name: 'less',
              location: 'vendor/require-less',
              main: 'less'
            },{
              name: 'cs',
              location: 'vendor',
              main: 'cs'
            },{
              name: 'css',
              location: 'vendor/css',
              main: 'css'
            },{
              name: 'coffee-script',
              location: 'vendor',
              main: 'coffee-script'
            },{
              name: 'i18n',
              location: 'vendor',
              main: 'i18n'
            }
          ]
          shim:
            'jquery.ui':['jquery']
            'jquery.tinymce':['jquery', 'tinymce']
            'jquery.form':['jquery']
            'bootstrap':['jquery']
            'minicolors':['jquery']
          dir: "cache/build/backend"
          # out: "cache/build/optimized.js"
          stubModules: ['cs', 'css', 'less', 'i18n']
          modules: [{
            name: 'main',
            exclude: ['coffee-script']
          }]
      frontend:
        options:
          baseUrl: './components/frontend'
          fileExclusionRegExp: /^server/
          paths:
            jquery: "vendor/jquery"
            fancybox: "vendor/fancybox/jquery.fancybox"
            lodash: "vendor/underscore"
            backbone: "vendor/backbone"
            marionette: "vendor/marionette"
            babysitter: "vendor/babysitter"
            wreqr: "vendor/wreqr"
            text: 'vendor/text'
            cs: 'vendor/cs'
            tpl: 'vendor/tpl'
            underscore: 'vendor/underscore'
          map:
            '*':
              'backbone.wreqr': 'wreqr'
              'backbone.babysitter': 'babysitter'
          packages: [
            {
              name: 'less',
              location: 'vendor/require-less',
              main: 'less'
            },{
              name: 'cs',
              location: 'vendor',
              main: 'cs'
            },{
              name: 'css',
              location: 'vendor/css',
              main: 'css'
            },{
              name: 'coffee-script',
              location: 'vendor',
              main: 'coffee-script'
            },{
              name: 'i18n',
              location: 'vendor',
              main: 'i18n'
            }
          ]
          shim:
            'jquery.ui':['jquery']
            'jquery.tinymce':['jquery', 'tinymce']
            'jquery.form':['jquery']
            'bootstrap':['jquery']
            'minicolors':['jquery']
          dir: "cache/build/frontend"
          stubModules: ['cs', 'css', 'less', 'i18n']
          modules: [{
            name: 'main',
            exclude: ['coffee-script', 'i18n', 'css', 'less']
          }]

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  grunt.loadNpmTasks 'grunt-mkdir'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-git'
  grunt.loadNpmTasks 'grunt-bowercopy'
  grunt.loadNpmTasks 'grunt-forever'

  # clean db
  grunt.registerTask 'dropDatabase', 'drop the database', ->
    done = this.async()
    db.connection.on 'open', ->
      db.connection.db.dropDatabase (err)->
        if err then console.log err else console.log 'Successfully dropped database'
        mongoose.connection.close done

  # TODO
  # grunt.registerTask 'backupDatabase', 'backup the database', ->
    # done = this.async()
    # db.connection.on 'open', ->
      # db.connection.db.dropDatabase (err)->
        # if err then console.log err else console.log 'Successfully dropped database'
        # mongoose.connection.close done


  grunt.registerTask 'install', 'Install the App', [
    'bower:install'
    'gitclone:baker:clone'
    'clean:baker'
    'mkdir:all'
    'bowercopy'
    'copy:tinymce' # translations for tinymce
    'clean:lib' #workaround ;()
    'build'
    'forever:server1:start'
  ]

  grunt.registerTask 'reinstall', 'Reinstalling the App', [
    'dropDatabase'
    'clean:reinstall'
    'install'
  ]
  grunt.registerTask 'reset', 'Reinstalling the App', [
    'dropDatabase'
    'clean:everything'
  ]

  grunt.registerTask 'build', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean:build'
    'requirejs'
    'restart'
  ]

  grunt.registerTask 'buildFrontend', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean:buildFrontend'
    'requirejs:frontend'
    'restart'
  ]

  grunt.registerTask 'buildBackend', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean:buildBackend'
    'requirejs:backend'
    'restart'
  ]

  grunt.registerTask 'restart', 'Restart the app daemon', [
    'forever:server1:stop'
    'forever:server1:start'
  ]

  return grunt