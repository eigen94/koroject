
var joint = require('trial');
var Channel = require('joint.com.channel.min').Channel;

var graph = new joint.dia.Graph;
var channel = new Channel({ port: 8082, graph: graph });

var channels = {};
var channelHub = new ChannelHub({ port: 8082 });
channelHub.route(function(req) {
    var query = JSON.parse(req.query.query);
    if (channels[query.room]) {
        // The room the client wants to connect to already exists, 
        // tell the ChannelHub which channel it should route further requests of this client.
        return channels[query.room];
    }
    // Yet unknown room. Create a channel for this room with a new JointJS graph and tell
    // the ChannelHub that further requests of this client should go to this new channel.
    return channels[query.room] = new Channel({ graph: new joint.dia.Graph });
});