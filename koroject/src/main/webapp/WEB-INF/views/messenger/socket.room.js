var fs = require('fs');

var server = require('http').createServer();

server.listen(8000, function(){
	console.log('Server Running at http://localhost:8000');
});

server.on('request', function(req, res){ 
	/*test*/console.log('request Call');
	fs.readFile( 'chatting.html', function(error, data){
		res.writeHead( 200, { 'Content-Type' : 'text/html' } );
		res.end( data );
	});
});

var io = require('socket.io').listen(server);

io.sockets.on( 'connection', function(socket){
	socket.on( 'join', function(data){
		console.log(data) // 방 이름이 무엇인고 ? 
		socket.join(data); 	//입력한 방 이름으로 접속 !! 
		socket.room = data; 
	});
	
	socket.on( 'message', function(data){
		console.log( 'id : %s, msg : %s', data.id, data.message );
//		console.log( 'id : %s, msg : %s, date : %s', data.id, data.message, data.date );
		
		//같은 방에 접속한 사용자들에게 메세지를 뿌림 
		io.sockets.in( socket.room ).emit('message', data); 
	});
});