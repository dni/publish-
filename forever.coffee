forever = require("forever")
child = new (forever.Monitor)("server.coffee",
  max: 1
  silent: true
  options: [1666]
  command: "coffee"
  logFile: "cache/development-log.txt"
  outFile: "cache/development-out.txt"
  errFile: "cache/development-err.txt"
)

child.on 'exit:code', (code)-> console.log('exit with code: '+code)
child.on 'start', -> console.log('start... ');
child.on 'watch:restart', (info)-> console.log('REstart... '+info.file)
child.on 'error', (err)-> console.log(err);
child.on 'stdout', (out)-> console.log("stdout: "+out)
child.on 'stderr', (err)-> console.log("stderr: "+err)

child.start()