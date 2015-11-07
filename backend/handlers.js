var models = require('./models.js');
var Playlist = models.Playlist;
var Song = models.Song;

//TODO how to do body vs params?
//TODO what is playlist id? name?

exports.getAllPlaylistsForUser = function(req, res) {
	console.log('received request to get all playlists');

	Playlist.find({
		user: req.params.userId
	}, function(err, playlists) {
		console.log('found playlists:', playlists);
		res.json(playlists);
		res.end();
	});
};

exports.getPlaylistForUser = function(req, res) {
	console.log('received request to get playlist');

	console.log(req.params.playlistId, req.params.userId);
	Playlist.findOne({
		_id: req.params.playlistId,
		user: req.params.userId
	}, function(err, playlist) {
		console.log('found playlist:', playlist);
		res.json(playlist);
		res.end();
	});
};

exports.createPlaylist = function(req, res) {
	console.log('received request to create playlist');

	// Make sure all songs have 0 votes
	var songs = req.body.songs || [];
	for (var i = 0; songs[i]; i++) songs[i].votes = 0;

	Playlist.create({
		name: req.body.name,
		user: req.params.userId,
		songs: songs
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to create user!"
		};

		console.log('created playlist:', playlist);

		res.json(playlist);
		res.end();
	});
};

exports.addSong = function(req, res) {
	Playlist.findOne({
		_id: req.params.playlistId,
		user: req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Failed to add song to playlist!"
		};

		var song = req.params;
		song.votes = 0;
		playlist.songs.push(song);
		playlist.save(function(err) {
			if (err) return {
				error: "Failed to add new song!"
			};
			console.log('updated playlist:', playlist);

			res.json(playlist);
			res.end();
		});


	});
};

exports.incrementCount = function(req, res) {
	Playlist.findOne({
		_id: req.params.playlistId,
		user: req.params.userId
	}, function(err, playlist) {
		if (err) return {
			error: "Could not find the song!"
		};

		var song = playlist.songs.id(req.params.songId);
		song.votes++;

		song.save(function(err) {
			if (err) return {
				error: "Failed to vote on song!"
			};

			res.json(song);
			res.end();
		});
	});
};