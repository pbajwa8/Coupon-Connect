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
    @IBOutlet var PicView: UIImageView!
    @IBOutlet var secondPicView: UIImageView!
    @IBOutlet var username1: UILabel!
    @IBOutlet var age1: UILabel!
    @IBOutlet var username2: UILabel!
    @IBOutlet var age2: UILabel!
    @IBOutlet var coupon1: UILabel!
    @IBOutlet var coupon2: UILabel!
    
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
        
        var business = ["19" : "Dooleys", "1157" : "Las Sirenas", "11573" : "Coupon Wallet Booth 529", "13302" : "It's a Dollar and Resale"]
        query!.findObjectsInBackgroundWithBlock( { (NSArray objects, NSError error) in
            if error == nil {
                var isOne = false
                if let objects = objects {
                    for object in objects {
                        if object.objectForKey("coupon1") as! String == currentUserCoupon2 {
                            isOne = true
                            let userImageFile = object["photo"] as! PFFile
                            userImageFile.getDataInBackgroundWithBlock {
                                (imageData: NSData?, error: NSError?) -> Void in
                                if error == nil {
                                    if let imageData = imageData {
                                        let image = UIImage(data:imageData)
                                        self.PicView.contentMode = .ScaleAspectFit
                                        self.PicView.image = image
                                        self.username1.text = object.objectForKey("username") as! String
                                        self.age1.text = object.objectForKey("age") as! String
                                        //self.coupon1.text = object.objectForKey("coupon1") as! String
                                        self.coupon1.text = business[currentUserCoupon2]
                                    }
                                }
                            }
                    
                        }
                        if object.objectForKey("coupon2") as! String == currentUserCoupon2 {
                            let userImageFile = object["photo"] as! PFFile
                            userImageFile.getDataInBackgroundWithBlock {
                                (imageData: NSData?, error: NSError?) -> Void in
                                if error == nil {
                                    if let imageData = imageData {
                                        let image = UIImage(data:imageData)
                                        if(isOne == false){
                                            isOne = true
                                            self.PicView.contentMode = .ScaleAspectFit
                                            self.PicView.image = image
                                            self.username1.text = object.objectForKey("username") as! String
                                            self.age1.text = object.objectForKey("age") as! String
                                            //self.coupon1.text = object.objectForKey("coupon2") as! String
                                            self.coupon1.text = business[currentUserCoupon2]
                                            }
                                        else{
                                            self.secondPicView.contentMode = .ScaleAspectFit
                                            self.secondPicView.image = image
                                            self.username2.text = object.objectForKey("username") as! String
                                            self.age2.text = object.objectForKey("age") as! String
                                            //self.coupon2.text = object.objectForKey("coupon2") as! String
                                            self.coupon2.text = business[currentUserCoupon2]
                                            }
                                        }
                                    }
                                }
                            }
                        
                        if object.objectForKey("coupon1") as! String == currentUserCoupon1 {
                            let userImageFile = object["photo"] as! PFFile
                            userImageFile.getDataInBackgroundWithBlock {
                                (imageData: NSData?, error: NSError?) -> Void in
                                if error == nil {
                                    if let imageData = imageData {
                                        let image = UIImage(data:imageData)
                                        if(isOne == false){
                                            isOne = true
                                            self.PicView.contentMode = .ScaleAspectFit
                                            self.PicView.image = image
                                            self.username1.text = object.objectForKey("username") as! String
                                            self.age1.text = object.objectForKey("age") as! String
                                            //self.coupon1.text = object.objectForKey("coupon1") as! String
                                            self.coupon1.text = business[currentUserCoupon1]
                                        }
                                        else{
                                            self.secondPicView.contentMode = .ScaleAspectFit
                                            self.secondPicView.image = image
                                            self.username2.text = object.objectForKey("username") as! String
                                            self.age2.text = object.objectForKey("age") as! String
                                            //self.coupon2.text = object.objectForKey("coupon1") as! String
                                            self.coupon2.text = business[currentUserCoupon1]
                                        }
                                    }
                                }
                                
                            }
                        }
                        
                        if object.objectForKey("coupon2") as! String == currentUserCoupon1 {
                            let userImageFile = object["photo"] as! PFFile
                            userImageFile.getDataInBackgroundWithBlock {
                                (imageData: NSData?, error: NSError?) -> Void in
                                if error == nil {
                                    if let imageData = imageData {
                                        let image = UIImage(data:imageData)
                                        if(isOne == false){
                                            isOne = true
                                            self.PicView.contentMode = .ScaleAspectFit
                                            self.PicView.image = image
                                            self.username1.text = object.objectForKey("username") as! String
                                            self.age1.text = object.objectForKey("age") as! String
                                           // self.coupon1.text = object.objectForKey("coupon2") as! String
                                            self.coupon1.text = business[currentUserCoupon1]
                                        }
                                        else{
                                            self.secondPicView.contentMode = .ScaleAspectFit
                                            self.secondPicView.image = image
                                            self.username2.text = object.objectForKey("username") as! String
                                            self.age2.text = object.objectForKey("age") as! String
                                            //self.coupon1.text = object.objectForKey("coupon2") as! String
                                            self.coupon1.text = business[currentUserCoupon1]
                                        }
                                    }
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
