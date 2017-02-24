//
//  ChatViewController.swift
//  Parse Chat
//
//  Created by Ulric Ye on 2/23/17.
//  Copyright © 2017 uye. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {
    
    @IBOutlet weak var messageInput: UITextField!
    
    @IBOutlet weak var TableView: UITableView!
    
    var messages: [PFObject]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.TableView.dataSource = self
        self.TableView.estimatedRowHeight = self.TableView.rowHeight
        self.TableView.rowHeight = UITableViewAutomaticDimension
        
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(ChatViewController.onTimer), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func sentMessage(_ sender: Any) {
        var messages = PFObject(className: "message")
        var user = PFUser.current()
        
        messages.saveInBackground {
            (success, error) in
            if(success) {
                print("success")
                
            } else {
                print("fail")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(messages != nil){
            return self.messages.count
        } else{
            return 0
        }
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        let message = messages[indexPath.row]
        cell.messageLabel?.text = message["text"] as? String
        //cell.usernameLabel.text = message["user"] as? String
        
        if let user = message["user"] as? PFUser {
            user.fetchInBackground(block: { (user, error) in
                if let user = user as? PFUser{
                    cell.usernameLabel.text = user.username
                }
            })
        }
        
        return cell
    }
    
    func query(){
        let query = PFQuery(className: "Message")
        query.findObjectsInBackground{
            (objects: [PFObject]?, error: Error?) -> Void in
            if error == nil {
                self.messages = objects
                self.TableView.reloadData()
                
            } else{
                print(error?.localizedDescription)
            }
        }
    }
    
    func onTimer(){
        query()
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

