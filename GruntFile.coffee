mongoose = require "mongoose"
db = mongoose.connect 'mongodb://localhost/publish'
Magazine = require __dirname+"/components/backend/modules/magazine/model/MagazineSchema"
HpubGenerator = require __dirname + "/components/backend/modules/magazine/generators/HpubGenerator"
fs = require "fs-extra"
module.exports = (grunt)->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    watch:
      scripts:
        files: ['components/**/*.coffee']
        tasks: ['test']
        options:
          spawn: false
      magazine:
        files: ['components/magazine/**/*']
        tasks: ['generateMagazine']
        options:
          spawn: false


    coffeelint:
      all:
        options:
          'max_line_length':
            level: 'ignore'
        files:
          src: ['components/backend/**/*.coffee', 'components/frontend/**/*.coffee']

    jasmine:

      backend:
        src: '*.js'
        options:
          specs: 'components/backend/modules/**/spec/*Spec.js'
          helpers: 'components/backend/modules/**/spec/*Helper.js'
          # host : 'http://localhost:1666/admin/'
          template: require 'grunt-template-jasmine-requirejs'
          templateOptions:
            requireConfigFile: 'components/backend/config.js'

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
          create: [
            'cache'
            'public/books'
            'public/files'
            'baker-master/books'
          ]
      useless:
        options:
          create: [
            'components/magazine/nudel'
          ]

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
          "tinymce": "tinymce-builded/js/tinymce"
          "minicolors": 'jquery-minicolors'
          "fancybox": "fancybox/source"
          "bootstrap": "bootstrap"
          "require-less": 'require-less'

      libsFrontend:
        options:
          destPrefix: "components/frontend/vendor"
        files:
          "jquery.js": "jquery/dist/jquery.js"
          "require.js": "requirejs/require.js"
          "backbone.js": "backbone-amd/backbone.js"
          "marionette.js": "marionette/lib/core/amd/backbone.marionette.js"
          "babysitter.js": "backbone.babysitter/lib/backbone.babysitter.js"
          "wreqr.js": "backbone.wreqr/lib/amd/backbone.wreqr.js"
          "coffee-script.js": 'coffee-script/index.js'
          "underscore.js": 'underscore-amd/underscore.js'
          "text.js": 'requirejs-text/text.js'
          "tpl.js": 'requirejs-tpl/tpl.js'
          "cs.js": 'require-cs/cs.js'
          "i18n.js": 'requirejs-i18n/i18n.js'
          # Folders
          "css": 'require-css'
          "fancybox": "fancybox/source"
          "bootstrap": "bootstrap"
          "require-less": 'require-less'

      libsMagazine:
        options:
          destPrefix: "components/magazine/js/vendor"
        files:
          "jquery.min.js": "jquery/dist/jquery.min.js"

    copy:
      tinymce:
        cwd: 'components/backend/modules/publish/nls/langs-tinymce'
        src: '*'
        dest: 'components/backend/vendor/tinymce/langs'
        expand: true

    requirejs:
      backend:
        options:
          baseUrl: './components/backend'
          fileExclusionRegExp: /^(server|spec)/
          mainConfigFile: "components/backend/config.js"
          dir: "cache/build/backend"
          stubModules: ['cs', 'css', 'less', 'i18n']
          modules: [{
            name: 'main'
            exclude: ['coffee-script', 'i18n', 'css', 'less']
          }]
      frontend:
        options:
          baseUrl: './components/frontend'
          fileExclusionRegExp: /^(server|spec)/
          mainConfigFile: "components/frontend/config.js"
          dir: "cache/build/frontend"
          stubModules: ['cs', 'css', 'less']
          modules: [{
            name: 'main'
            exclude: ['coffee-script', 'css', 'less']
          }]

  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'

  grunt.loadNpmTasks 'grunt-contrib-jasmine'
  grunt.loadNpmTasks 'grunt-coffeelint'

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

  # clean db
  grunt.registerTask 'generateMagazine', 'generate hpub and print', ->
    #remake all magazines and pages
    child_process = require("child_process").spawn
    spawn = child_process("rm", ["-r", 'books'], cwd: "./public/")
    spawn.on "exit", (code) ->
      if code isnt 0
        console.log "remove Magazines  exited with code " + code
      else
        fs.mkdirSync "./public/books"
        Magazine.find().execFind (err, data) ->
          for d in data
            fs.mkdirSync "./public/books/" + d.name
            fs.copySync "./components/magazine/gfx", "./public/books/" +  d.name + "/hpub/gfx"
            fs.copySync "./components/magazine/css", "./public/books/" +  d.name + "/hpub/css"
            fs.copySync "./components/magazine/js", "./public/books/" +  d.name + "/hpub/js"
            fs.copySync "./components/magazine/images", "./public/books/" +  d.name + "/hpub/images"
            HpubGenerator.generate d

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
    # 'copy:tinymce' # translations for tinymce
    'clean:lib' #workaround ;()
    'build'
    'forever:server1:start'
  ]

  grunt.registerTask 'reinstall', 'Reinstalling the App', [
    'forever:server1:stop'
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
  ]

  grunt.registerTask 'buildFrontend', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean:buildFrontend'
    'requirejs:frontend'
  ]

  grunt.registerTask 'buildBackend', 'Compiles all of the assets and copies the files to the build directory.', [
    'clean:buildBackend'
    'requirejs:backend'
  ]

  grunt.registerTask 'test', 'Test the App with Jasmine and Coffeelint', ['coffeelint', 'jasmine', 'restart']

  grunt.registerTask 'restart', 'Restart the app daemon', [
    'forever:server1:stop'
    'forever:server1:start'
  ]

  return grunt
