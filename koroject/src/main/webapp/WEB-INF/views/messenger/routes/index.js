var express = require('express');
var router = express.Router();





	exports.index = function(req, res){
		alert("index");
	res.render('template',{
		title:req.param('gogogo')
		});
	};
	
