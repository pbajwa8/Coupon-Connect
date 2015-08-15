//
//  LoginViewController.swift
//  Coupon Connect
//
//  Created by Parambir Bajwa on 8/14/15.
//  Copyright (c) 2015 Parambir Bajwa. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!

    override func viewDidLoad() {
        self.navigationController?.navigationBarHidden = true
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signIn(sender: AnyObject) {
        PFUser.logInWithUsernameInBackground(self.usernameField.text, password:self.passwordField.text) {
            (user: PFUser?, error: NSError?) -> Void in
            if user != nil {
                var currentUser: PFUser = PFUser.currentUser()!
                var userId: String! = currentUser["userId"] as! String
                println(userId)
                var couponsUrl = "http://service.sandbox.cw.cm?API_KEY=54090b6a70faf7b1cbe27305e6&method=get_wallet_info&u=" + userId + "&OUTPUT=json"
                
                println(couponsUrl)
                
                let getCouponsUrl = NSURL(string: couponsUrl)
                
                let getCoupons = NSURLSession.sharedSession().dataTaskWithURL(getCouponsUrl!) {(data, response, error) in
                    let json = JSON(data: data)
                    if json[0]["accepted_businesses"].string != nil {
                        currentUser["coupon1"] = json[0]["accepted_businesses"].string as String!
                    }
                    if json[1]["accepted_businesses"].string != nil {
                       currentUser["coupon2"] = json[1]["accepted_businesses"].string as String!
                    }
                    currentUser.save()
                    println("coupons saved")
                }
                getCoupons.resume()
            } else {
                println(error)
            }
        }
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
