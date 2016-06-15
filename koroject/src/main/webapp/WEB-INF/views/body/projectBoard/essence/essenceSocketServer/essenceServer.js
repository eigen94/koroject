var express = require('express')
	,http = require('http')
	,app = express()
	,server = http.createServer(app);
var bodyParser = require('body-parser');
var tmpSave={};

var cnt=0;
app.use(bodyParser.urlencoded({     // to support URL-encoded bodies
  extended: true
})); 
app.use(bodyParser.json());
app.use(bodyParser.text());

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.get('/', function(req, res, next) {
  // Handle the get for this route
	res.send('get req');
});

app.post('/', function(req, res, next) {
 // Handle the post for this route
});

app.post('/export', function(req, res, next) {
	// Handle the post for this route
	console.log(req.body.milestone)
	console.log(req.body.p_id)
	tmpSave[req.body.p_id] = req.body.milestone;
	console.log(tmpSave)
});

app.post('/import', function(req, res, next) {
	// Handle the post for this route
	res.send(tmpSave[req.body.p_id]);
});

app.post('/more', function(req, res, next) {
	// Handle the post for this route
});
	

	


server.listen(10000, function(){
	console.log('listening'+server.address().port);
});
