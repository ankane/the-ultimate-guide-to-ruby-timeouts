var net = require('net');

var server = net.createServer(function(socket) {
  socket.on('data', function(data) {
    console.log(data);
  });
});

console.log('Ready for connections (use another window to run tests)...')
server.listen(4567, '127.0.0.1');
