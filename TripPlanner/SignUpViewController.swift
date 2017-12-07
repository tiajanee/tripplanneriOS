//
//  SignUpViewController.swift
//  TripPlanner
//
//  Created by Tia King on 12/6/17.
//  Copyright © 2017 Tia King. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func submit(_ sender: UIButton) {
        submit()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    func submit() {
        
        //declare parameter as a dictionary which contains string as key and value combination.
        let userCredentials = User(email: self.email.text!, password: self.password.text!)
        print(userCredentials)
        
        //create the url with NSURL
        let url = NSURL(string: "https://tripplannerproduction.herokuapp.com/")
        //
        //create the session object
        let session = URLSession.shared
        
        //now create the NSMutableRequest object using the url object
        let request = NSMutableURLRequest(url: url! as URL)
        request.httpMethod = "POST" //set http method as POST
        
        do {
            request.httpBody = try JSONEncoder().encode(userCredentials) // converts body to JSON
            
        } catch let error {
            print(error.localizedDescription)
        }
        
        //HTTP Headers
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        //create dataTask using the session object to send data to the server
        let task = session.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            print(response)
            guard error == nil else {
                return
            }
        })
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

