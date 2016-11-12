//
//  ViewController.swift
//  DeltaStalker
//
//  Created by Yongsung on 11/11/16.
//  Copyright © 2016 Delta. All rights reserved.
//

import UIKit

import Firebase


class ViewController: UIViewController, ESTBeaconManagerDelegate, GIDSignInUIDelegate, GIDSignInDelegate {
    
    var userId : String! = ""
    var fullName : String!
    let beaconManager = ESTBeaconManager()

    
    public func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let err = error {
            print(err)
        }
        else {
            self.userId = user.userID                  // For client-side use only!
            let idToken = user.authentication.idToken // Safe to send to the server
            self.fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print("login info is", userId, fullName)

            performSegue(withIdentifier: "pushSegue", sender: self)
        }
    }



    var DSTableViewController: DSTableViewController!
    var ref: FIRDatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = FIRDatabase.database().reference()

        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().signInSilently()
        GIDSignIn.sharedInstance().delegate = self
        
        self.beaconManager.delegate = self
        self.beaconManager.requestAlwaysAuthorization()
        // need to change
        self.beaconManager.startMonitoring(for: CLBeaconRegion(proximityUUID: UUID(uuidString: "B9407F30-F5F8-466E-AFF9-25556B57FE6D")!, major: 5625, minor: 59582, identifier:"delta"))
        // Do any additional setup after loading the view, typically from a nib.
    }

    func storeInDb(userId : String, fullName : String){

        self.ref.child("in-the-lab").child(userId).setValue(["fullName": fullName])
    }
    
    func beaconManager(_ manager: Any, didEnter region: CLBeaconRegion) {
        print("entered")
        if(userId != ""){
            storeInDb(userId: userId, fullName: fullName)

        }
        
    }
    
    
    func beaconManager(_ manager: Any, didExitRegion region: CLBeaconRegion) {
        print("exited")
        self.ref.child("in-the-lab").child(userId).removeValue()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

