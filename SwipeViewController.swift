//
//  SwipeViewController.swift
//  Coupon Connect
//
//  Created by Parambir Bajwa on 8/14/15.
//  Copyright (c) 2015 Parambir Bajwa. All rights reserved.
//

import UIKit

class SwipeViewController: UIViewController {

    @IBOutlet var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true
        var matchedUsers: [String] = []
        
        var currentUser: PFUser = PFUser.currentUser()!
        var currentUserGender: String! = currentUser["gender"] as! String
        var currentUserCoupon1: String! = currentUser["coupon1"] as! String
        var currentUserCoupon2: String! = currentUser["coupon2"] as! String
        var currentUserUsername: String! = currentUser["username"] as! String
        
        var requestedGender = ""
        
        if currentUserGender == "M" {
            requestedGender = "F"
        } else if currentUserGender == "F" {
            requestedGender = "M"
        }
        
        var query = PFUser.query()
        query!.whereKey("gender", equalTo:requestedGender)
        
        query!.findObjectsInBackgroundWithBlock( { (NSArray objects, NSError error) in
            if error == nil {
                if let objects = objects {
                    for object in objects {
                        if object.objectForKey("coupon1") as! String == currentUserCoupon2 {
                            var matches = PFObject(className:"matches")
                            matches["currentUser"] = currentUserUsername
                            matches["matchedUser"] = object.objectForKey("username") as! String
                            matches["age"] = object.objectForKey("age") as! String
                            matches["matchedCoupon"] = currentUserCoupon2
                            matches["photo"] = object.objectForKey("photo")
                            matches.saveInBackgroundWithBlock {
                                (success: Bool, error: NSError?) -> Void in
                                if (success) {
                                   print("saved")
                                } else {
                                    print("fuck this shit")
                                }
                            }
                        } else if object.objectForKey("coupon2") as! String == currentUserCoupon2 {
                            var matches = PFObject(className:"matches")
                            matches["currentUser"] = currentUserUsername
                            matches["matchedUser"] = object.objectForKey("username") as! String
                            matches["age"] = object.objectForKey("age") as! String
                            matches["photo"] = object.objectForKey("photo")
                            matches["matchedCoupon"] = currentUserCoupon2
                            matches.saveInBackgroundWithBlock {
                                (success: Bool, error: NSError?) -> Void in
                                if (success) {
                                    print("saved")
                                } else {
                                    print("fuck this shit")
                                }
                            }

                        } else if object.objectForKey("coupon1") as! String == currentUserCoupon1 {
                            var matches = PFObject(className:"matches")
                            matches["currentUser"] = currentUserUsername
                            matches["matchedUser"] = object.objectForKey("username") as! String
                            matches["age"] = object.objectForKey("age") as! String
                            matches["photo"] = object.objectForKey("photo")
                            matches["matchedCoupon"] = currentUserCoupon1
                            matches.saveInBackgroundWithBlock {
                                (success: Bool, error: NSError?) -> Void in
                                if (success) {
                                    print("saved")
                                } else {
                                    print("fuck this shit")
                                }
                            }

                        }
                    }
                }
            }
        })
        
        // Do any additional setup after loading the view.
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
