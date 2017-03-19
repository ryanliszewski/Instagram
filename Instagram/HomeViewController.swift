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
    
    
    
    /**
        
        Tableview
     
    */
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostTableViewCell
        
        print(posts.count)
        cell.post = posts[(posts.count - 1) - indexPath.section]
        
        return cell
    }
    
    /**
     
        Table View -> Header View
 
    */
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 40))
        
        let profileView = UIView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
        
        let usenameLabel = UILabel(frame: CGRect(x: 60, y: 10, width: 100, height: 20)
            
        
        
        
        
        
        
        return tableView.tableHeaderView
    }
    
    //Size of TableVIew header view
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40.0
    }
    
    /**
     
        Table View -> FooterView
 
    */
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return tableView.tableFooterView
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat{
        return 100
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
