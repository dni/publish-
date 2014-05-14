module.exports = (grunt)->
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    # bower:
      # all:
        # rjsConfig: "components/backend/config.js"

    # bowercopy:
      # dev:
        # libs:
          # options:
            # destPrefix: 'components/backend/vendor/libs'
          # files:
            # 'jquery.js': 'jquery/jquery.js'
            # 'require.js': 'requirejs/require.js'
#
        # plugins:
          # options:
            # destPrefix: 'components/backend/vendor/plugins'
          # files:
            # 'jquery.chosen.js': 'chosen/public/chosen.js'
#
        # less:
          # options:
            # destPrefix: 'components/backend/vendor/less'
          # files:
            # src: 'bootstrap/less/bootstrap.less'

    #copy
    copy:
      build:
        cwd: 'components'
        src: [ '**' ]
        dest: 'cache/build'
        expand: true

    #clean
    clean:
      build:
        src: [ 'cache/build' ]


  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-requirejs'
  grunt.loadNpmTasks 'grunt-bowercopy'

  grunt.registerTask 'dev', 'Prepare for Development', [ 'clean', 'copy' ]
  grunt.registerTask 'build', 'Compiles all of the assets and copies the files to the build directory.', [ 'clean', 'copy' ]

  return grunt