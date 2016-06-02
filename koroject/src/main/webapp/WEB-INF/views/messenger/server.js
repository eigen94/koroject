/*var io = require('socket.io').listen(50000);

io.sockets.on('connection', function(socket) {
    socket.emit('connection', {
        type : 'connected'
    });

    socket.on('connection', function(data) {
        if(data.type == 'join') {

            socket.join(data.room);

            socket.set('room', data.room);

            socket.emit('system', {
                message : '채팅방에 오신 것을 환영합니다.'
            });

            socket.broadcast.to(data.room).emit('system', {
                message : data.name + '님이 접속하셨습니다.'
            });
        }
    });

    socket.on('user', function(data) {
        socket.get('room', function(error, room) {
            socket.broadcast.to(room).emit('message', data);
        });
    });

});*/


var app = require('express')();
var http = require('http').Server(app);
var io = require('socket.io')(http);
var fs = require('fs');

app.get('/', function(request, response){
	fs.readFile('client.html', function(error, data){
		 response.send(data.toString());
	 });
//	res.sendFile(__dirname + '/client.html');
});

io.on('connection', function(socket){
  socket.on('chat message', function(msg){
    io.emit('chat message', msg);
  });
});

http.listen(3000, function(){
  console.log('listening on *:3000');
});


/*
var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');
 
var routes = require('./routes/index');
var users = require('./routes/users');
var chat = require('./routes/chat'); // 추가
 
var app = express();
var http = require('http').Server(app); // 추가
var io = require('socket.io')(http); // 추가
 
// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
 
// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
//app.use(logger('dev')); // 주석처리
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));
app.set( "ipaddr", "127.0.0.1" ); // 추가
app.set( "port", 3000 ); // 추가
 
 
*//*** Routing ***//*
app.use('/', routes);
app.use('/users', users);
app.use('/chat', chat); // 추가
 
http.listen(app.get('port'), function(){
    console.log("Express server listening on port " + app.get('port'));
}); // 추가
 
*//*** Socket.IO 추가 ***//*
io.on('connection', function(socket){
     
    console.log('a user connected');
     
    socket.broadcast.emit('hi');
     
    socket.on('disconnect', function(){
        console.log('user disconnected');
    });
     
    socket.on('chat message', function(msg){
        console.log('message: ' + msg);
        io.emit('chat message', msg);
    });  
 
}); 
 
 
// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});
 
// error handlers
 
// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}
 
// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});
 
 
module.exports = app;
 
*/