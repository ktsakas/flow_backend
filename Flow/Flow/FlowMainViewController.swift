//
//  FlowMainViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//

import UIKit

class FlowMainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    let songCellID = "songCell"
    
    var playlist = Playlist(name: "Valentin's Flow", user: User(name: "Valentin", id:"id7"), id: "playlistId1")
    
    @IBOutlet var tableView: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create playlist broaugh
        //        playlist = Playlist(name: "Valentin's Flow", user: User(name: "Valentin", id:"id7"), id: "playlistId1")
        
        tableView.delegate = self
        tableView.dataSource = self

        FlowNetwork.createPlaylist(playlist, callback: {
            FlowNetwork.addSongs(self.playlist, songs: FlowNetwork.getFakeSongs(), i: 0, callback: {
                self.tableView.reloadData()
            })
        })
                

//        tableView.reloadData()
        
        
        //        FlowNetwork.createPlaylist(playlist, callback: {
        //            print("created playlist yay")
        //
        //            let song1 = Song(id: "song1", name: "song1", artist: "_", votes: 0, imageLink: "_", songLink: "_")
        //
        //            FlowNetwork.addSong(song1, playlist: self.playlist, callback: {
        //
        //                let song2 = Song(id: "song2", name: "song2", artist: "_", votes: 0, imageLink: "_", songLink: "_")
        //
        //                FlowNetwork.addSong(song2, playlist: self.playlist, callback: {
        //                    self.playlist.print_self()
        //
        //                    let song1id = self.playlist.songs[0].id
        //                    let song2id = self.playlist.songs[1].id
        //
        //                    print("song1id: \(song1id), song2id: \(song2id)")
        //
        //                    FlowNetwork.incrementVoteForSong(song1id, playlist: self.playlist, callback: {
        //                        FlowNetwork.incrementVoteForSong(song1id, playlist: self.playlist, callback: {
        //                            FlowNetwork.incrementVoteForSong(song2id, playlist: self.playlist, callback: {
        //                                FlowNetwork.incrementVoteForSong(song2id, playlist: self.playlist, callback: {
        //                                    FlowNetwork.incrementVoteForSong(song2id, playlist: self.playlist, callback: {
        //                                        self.playlist.print_self();
        //                                    })
        //                                })
        //                            })
        //                        })
        //                    })
        //                })
        //            })
        //        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    /**
     *  //MARK: - TableView Delegate
     * TableView Delegate Methods
     */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //songCell.setHighlighted(false, animated: false)
        print("selected song brah")

      FlowNetwork.updatePlaylist(playlist) { (returned) -> Void in
        tableView.reloadData()
      }


    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let songCell : SongTableViewCell = tableView.dequeueReusableCellWithIdentifier(songCellID, forIndexPath: indexPath) as! SongTableViewCell
        
        print(indexPath.row)
        
        let song : Song = playlist.songs[indexPath.row]
        songCell.songTitleLabel.text = song.name
        songCell.songArtistLabel.text = song.artist
        //let votes = playlist.songs.count - indexPath.row
        songCell.voteCountLabel.text = "\(song.votes)"
        
        songCell.songId = song.id
        songCell.playlist = playlist
        songCell.selectionStyle = .None
        
        return songCell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2 // we have one for currently playing and the other for songs coming up next.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (playlist.songs.count == 0) {
            return 0
        } else if (section == 0) {
            return 1 // the one currently playing
        } else {
            return playlist.songs.count - 1 // all the others.
        }
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0) {
            return "Now Playing"
        }
        return "Next"
    }
    
    func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView //recast your view as a UITableViewHeaderFooterView
        header.contentView.backgroundColor =  UIColor.lightGrayColor()//UIColor.clearColor()//UIColor(red: 30/255, green: 30/255, blue: 30/255, alpha: 0.0) //make the background color light blue
        
        header.textLabel!.textColor = UIColor.whiteColor() //make the text white
        header.alpha = 1 //make the header transparent
    }
    
    
    
    
    /*
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
    }
    */
    
}
