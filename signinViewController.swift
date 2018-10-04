//
//  signinViewController.swift
//  Eventos
//
//  Created by Deema Alrasheed on 10/01/1440 AH.
//  Copyright © 1440 Ghada Jamal. All rights reserved.
//

import UIKit
import FirebaseAuth

class signinViewController: UIViewController {

    
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var password: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButton(_ sender: Any) {
        print("log in button tapped")
        
        let userName = username.text
        let userPassword = password.text
        
        
        if (userName?.isEmpty)! || (userPassword?.isEmpty)!
        
        {
            print("User name \(String(describing: userName)) or password \(String(describing: userPassword)) is empty  ")
            
            displayMessage(userMessage: " One of the required fields is missing")
            
            return 
            
            
            
        }
        
        
        
        let myActivityIndicator=UIActivityIndicatorView(style: .gray)
        
        // Position Activity Indicator in the center of the main view
        myActivityIndicator.center = view.center
        
        // If needed, you can prevent Acivity Indicator from hiding when stopAnimating() is called
        myActivityIndicator.hidesWhenStopped = false
        
        // Start Activity Indicator
        myActivityIndicator.startAnimating()
        
        view.addSubview(myActivityIndicator)
        
        /*
            let myUrl = URL(string:"https://gdoo84.000webhostapp.com/Store.php")
        var request = URLRequest(url:myUrl!)
        request.httpMethod = "POST"
        request.addValue("application/json" , forHTTPHeaderField: "content-type")
         request.addValue("application/json" , forHTTPHeaderField: "Accept")
        
        let postString = "usename=\(userName!)&password=\(userPassword!)"
        
        do {
            request.httpBody = try JSONSerialization.data( withJSONObject: postString, options: .prettyPrinted ) }
        catch let eror {
            print(eror.localizedDescription)
            displayMessage(userMessage: "Something went wrong... ")
            return
        }
        
        let task = URLSession.shared.dataTask(with: request as URLRequest){
            data, response, error in
            
            self.removeActivityIndicator(activityIndicator: myActivityIndicator)
            
            if error != nil
            {
               self.displayMessage(userMessage: "Could not successfully perform this request . please try again later  ")
                print ("error=\(String(describing: error))")
                return
                
            }
            
            
            do {
               
                let json = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:AnyObject]
     
                
                if let parseJSON = json {
                    let accessToken = parseJSON["username"] as? String
                    let pass = parseJSON["password"] as? String
                    print ("Access token: \(String(describing: accessToken!))")
                    
                    if (accessToken?.isEmpty)!
                    {
                       self.displayMessage(userMessage: "Could not successfully perform this request . please try again later  ")
                        
                        return
                    }
                    
                    DispatchQueue.main.async {
                        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                        let appDelegate = UIApplication.shared.delegate
                        appDelegate?.window??.rootViewController = homePage
                        
                    }
                   
                    
                }
                else {
                     self.displayMessage(userMessage: "Could not successfully perform this request . please try again later  ")
                    
                }
              
            }
            
            catch {
                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
         
                self.displayMessage(userMessage: "Could not successfully perform this request . please try again later  ")
               print(error)
            }
            
            
        }
        
         task.resume()
        
        */
        
        
        
        
             self.removeActivityIndicator(activityIndicator: myActivityIndicator)
        
        
        
        //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
        
       
        if self.username.text == "" || self.password.text == "" {
            
            //Alert to tell the user that there was an error because they didn't fill anything in the textfields because they didn't fill anything in
            
            let alertController = UIAlertController(title: "Error", message: "Please enter an email and password.", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            self.present(alertController, animated: true, completion: nil)
            
        } else {
            
            Auth.auth().signIn(withEmail:username.text!, password: self.password.text!) { (user, error) in
                
                if error == nil {
                    
                    //Print into the console if successfully logged in
                    print("You have successfully logged in")
                    
                    //Go to the HomeViewController if the login is sucessful
                    /*
                    let homePage = self.storyboard?.instantiateViewController(withIdentifier: "HomePageViewController") as! HomePageViewController
                    let appdelegate = UIApplication.shared.delegate
                    appdelegate?.window??.rootViewController = homePage
                     */
                    //self.navigationController pushViewController:HomePageViewController animated: YES
                 self.performSegue(withIdentifier: "segue", sender: self)
                    
                } else {
                    
                    //Tells the user that there is an error and then gets firebase to tell them the error
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
       print("register button tapped")
    }

    func displayMessage(userMessage: String)-> Void{
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: "Alert", message:
                userMessage, preferredStyle: .alert)
            
            let OKAction = UIAlertAction(title: "OK", style: .default)
            { (action: UIAlertAction!) in
                print("Ok button tapped")
            }
            alertController.addAction(OKAction)
            self.present(alertController, animated: true, completion: nil)
        }
        
    }
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async{
         activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
            
            
        }
        
        
        
    }
    /*
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        var welcome = segue.destination as! HomePageViewController
        welcome.myString = username.text!
    }
    */

}
