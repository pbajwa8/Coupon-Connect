//
//  SignUpViewController.swift
//  Coupon Connect
//
//  Created by Parambir Bajwa on 8/14/15.
//  Copyright (c) 2015 Parambir Bajwa. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var usernameField: UITextField!
    @IBOutlet var passwordField: UITextField!
    @IBOutlet var ageField: UITextField!
    @IBOutlet var genderField: UITextField!
    @IBOutlet var zipcodeField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBarHidden = true

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUp(sender: AnyObject) {
        
        var userAccessToken = ""
        var userId = ""
        
        var tokenUrl = "http://auth.sandbox.cw.cm/login?API_KEY=54090b6a70faf7b1cbe27305e6&login_service=couponwallet&password=" + self.passwordField.text + "&username=" + self.usernameField.text
        
        let getTokenUrl = NSURL(string: tokenUrl)
        
        let getToken = NSURLSession.sharedSession().dataTaskWithURL(getTokenUrl!) {(data, response, error) in
            if (error != nil) {
                println(error)
                println("THIS IS AN ERROR")
            } else {
                let json = JSON(data: data)
                userAccessToken = json["access_token"].string as String!
                println(userAccessToken)
                var idUrl = "http://service.sandbox.cw.cm?API_KEY=54090b6a70faf7b1cbe27305e6&method=get_user_by_token&access_token=" + userAccessToken + "&OUTPUT=json"
                
                let getUserIdUrl = NSURL(string: idUrl)
                
                let getUserId = NSURLSession.sharedSession().dataTaskWithURL(getUserIdUrl!) {(data, response, error) in
                    let json = JSON(data: data)
                    userId = json["u"].string as String!
                    var user = PFUser()
                    user.username = self.usernameField.text
                    user.password = self.passwordField.text
                    user["age"] = self.ageField.text
                    user["gender"] = self.genderField.text
                    user["zipcode"] = self.zipcodeField.text
                    user["userId"] = userId
                    
                    user.signUpInBackgroundWithBlock {
                        (succeeded: Bool, error: NSError?) -> Void in
                        if let error = error {
                            let errorString = error.userInfo?["error"] as? NSString
                            println(errorString)
                        } else {
                            println("User Created")
                        }
                }
                
                
            }
                getUserId.resume()
        }
        

    }
    getToken.resume()
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    }
 }
