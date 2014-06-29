winston = require 'winston'

winston.exitOnError = false
winston.level = 'info'


module.exports = (module) ->
  filename = module.id
  return {
    info: (msg, vars) -> winston.info "[#{filename}] " + msg, vars
    warn: (msg, vars) -> winston.warn "[#{filename}] " + msg, vars
    error: (msg, vars) -> winston.error "[#{filename}] " + msg, vars
    debug: (msg, vars) -> winston.debug "[#{filename}] " + msg, vars  
    log: (info, msg, vars) -> winston.log "[#{filename}] #{info}", msg, vars
  }