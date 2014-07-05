require('coffee-script/register');
tester = require('./tester')

var http = require('http');

http.createServer(function(req, res) {
  res.end('hello');
}).listen(7777);