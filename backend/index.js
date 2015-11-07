var express = require('express');
var bodyParser = require('body-parser');
var mongoose = require('mongoose');
var passport = require('passport');
var FacebookStrategy = require('passport-facebook').Strategy;

//local modules
var handlers = require('./handlers.js');

var app = express();
var PORT = 80;

mongoose.connect('mongodb://localhost'); //'localhost:27017');

var Playlist = mongoose.model('Playlist', {
	name: String,
	user: String,
	songs: []
});

// Middleware to parse the body
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({
	extended: true
}));


// Get all playlists for user
app.get('/users/:userId/playlists', handlers.getAllPlaylistsForUser);

// Get playlist for user
app.get('users/:userId/playlists/:playlistId', handlers.getPlalistForUser);

// Create playlist
app.post('/users/:userId/playlists', handlers.createPlaylist);

// add a song to a playlist
app.post('/users/:userId/playlists/:playlistId', handlers.addSong);

// increment the voteCount for a song in a playlist
app.post('/users/:userId/playlists/:playlistId', handlers.incrementCount);



app.get('/', function(req, res) {
	// console.log(req.params.test);

	res.send('Hello World!');
	res.end();
});

app.listen(PORT, function() {
	console.log('Server listening on port: %s', PORT);
});