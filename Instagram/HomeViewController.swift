//
//  HomeViewController.swift
//  Instagram
//
//  Created by Ryan Liszewski on 3/5/17.
//  Copyright © 2017 Smiley. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD
import ParseUI

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var postTableView: UITableView!
    
    var posts: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postTableView.delegate = self
        postTableView.dataSource = self
        
        MBProgressHUD.showAdded(to: self.view, animated: true)
        
        getPosts()
        // Do any additional setup after loading the view.
    }
    
    override  func viewDidAppear(_ animated: Bool){

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getPosts(){
        let query = PFQuery(className: "Post")
        query.limit = 20
        
        query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
            if let posts = posts {
                print("GOT POSTS")
                self.posts = posts
                self.updateTableView()
            } else {
                print(error?.localizedDescription)
            }
        }
    
        
        
        
    }
    
    func updateTableView(){
        MBProgressHUD.hide(for: self.view , animated: true)
        self.postTableView.reloadData()
    }
    
    @IBAction func onLogoutButtonTapped(_ sender: Any) {
        PFUser.logOutInBackground()
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "User did Logout"), object: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if (posts != nil) {
            return posts.count
        }else {
            return 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        
        print(posts.count)
        cell.post = posts[indexPath.row]
        
        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
