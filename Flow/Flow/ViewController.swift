//
//  ViewController.swift
//  Flow
//
//  Created by Valentin Perez on 11/6/15.
//  Copyright © 2015 Valpe Technologies. All rights reserved.
//


import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

  let flowNames = ["Join Valentin's Flow", "Create Flow"]

  @IBOutlet var tableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()

    tableView.dataSource = self
    tableView.delegate = self
    tableView.reloadData()
    // Do any additional setup after loading the view.


    let loginButton = FBSDKLoginButton()
    loginButton.center = self.view.center
    self.view.addSubview(loginButton)

//    FBSDKLoginButton *loginButton = [[FBSDKLoginButton alloc] init];
    // Optional: Place the button in the center of your view.
  //  loginButton.center = self.view.center;
   // [self.view addSubview:loginButton];
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
    print("selected FLOW brah")

    //let vc = storyboard?.instantiateViewControllerWithIdentifier("flowMainController") as! FlowMainViewController

    //vc.playlist = Playlist(name: "Valentin's Flow", user: User(name: "Valentin", id:"userIdValentin"), id: "playlistId1")
    self.performSegueWithIdentifier("toFlowSegue", sender: self)

    //self.presentViewController(nvc, animated: true, completion: nil)
  }

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let flowCell : FlowNameTableViewCell = tableView.dequeueReusableCellWithIdentifier("flowCell", forIndexPath: indexPath) as! FlowNameTableViewCell

    flowCell.nameLabel.text = flowNames[indexPath.row]
    return flowCell

  }

  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

    return flowNames.count
  }



}

