var net = require('net');

var server = net.createServer(function(socket) {
  socket.on('data', function(data) {
    console.log(data);
  });
});

server.listen(4567, '127.0.0.1');
