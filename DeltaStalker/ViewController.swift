//
//  ViewController.swift
//  DeltaStalker
//
//  Created by Yongsung on 11/11/16.
//  Copyright © 2016 Delta. All rights reserved.
//

import UIKit

class ViewController: UIViewController, ESTBeaconManagerDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print(err)
        }
        else {
            performSegue(withIdentifier: "pushSegue", sender: self)
        }
    }


    var DSTableViewController: DSTableViewController!
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

