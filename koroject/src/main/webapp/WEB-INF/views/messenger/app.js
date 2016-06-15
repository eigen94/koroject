// opens file system
var fs = require('fs');

// creates WebServer
var http = require('http');

var connect = require('express');
var app = connect();
var socketio = require('socket.io');
var url = require('url');
//채팅ID
var email = "";
//채팅방 이름
var roomName = "";

// open mongoose
var mongoose = require('mongoose');

// connects to MongoDB / the name of DB is set to 'messenger'
mongoose.connect('mongodb://dinky.iptime.org/messenger');

// get the connection from mongoose
var db = mongoose.connection;

// 에러일 경우 출력될 메세지
db.on('error', console.error.bind(console, 'connection error:'));
// 정상 실행될 경우 메세지
db.once('open', function callback() {
	// if connection open succeeds print out the following in the console

});

// MongoDB를위한 스키마 생성 / requires 'username' & 'message'
var userSchema = mongoose.Schema({
	username : 'string',
	message : 'string',
	roomname : 'string'
});

// 모델에 유저스키마 컴파일
var Chat = mongoose.model('Chat', userSchema);

// 웹에서 요청이 온 경우
app.use('/', function(req, res, next) {
	
	//url에서 데이터를 뽑아온다.
	var uri = req.url;
	var query = url.parse(uri, true).query;
	
	email = query.email;
	roomName = query.p_id;
	
	if (req.url != '/favicon.ico') {
		fs.readFile(__dirname + '/chatting.html', function(error, data) {
			res.writeHead(200, {
				'Content-Type' : 'text/html'
			});
			res.write(data);
			res.end();
		});
	}
});

// creates server
var server = http.createServer(app);
server.listen(7777, function() {
	console.log('server listen on port 7777');
});

// creates WebSocket Server
var io = socketio.listen(server);

// 웹소켓이 연결되는 순간 실행된다.
io.sockets.on('connection', function(socket) {

	io.sockets.emit('nameSet', email);
	io.sockets.emit('roomSet', roomName);
	socket.join(roomName); // 입력한 방 이름으로 접속 !!
	
	

	socket.on('breakdown', function(data) {
		// DB에서 최근 대화내역을 불러온다.
		Chat.find(function(err, result) {
			for (var i = 0; i < result.length; i++) {
				var dbData = {
					name : result[i].username,
					message : result[i].message,
					roomname : result[i].roomname
				};
				io.sockets.sockets[socket.id].emit('preload', dbData);
			}
		});
	});

	// DB에 data(username + message) 식으로 저장한다.
	socket.on('message', function(data) {
		//웹상에 채팅 내역을 보여준다. 
		io.sockets.emit('message', data);
		
		//데이터 저장을 위해 변수에 넣고 
		var chat = new Chat({
			username : data.name,
			message : data.message,
			roomname : data.roomname
		});

		//db에 저장
		chat.save(function(err, data) {
			if (err) {
				console.log("error");
			}
			console.log('message is inserted');
		});

	});
});