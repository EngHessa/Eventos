//
//  SignUpViewController.swift
//  Eventos
//
//  Created by Deema Alrasheed on 10/01/1440 AH.
//  Copyright © 1440 Ghada Jamal. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController {


    @IBOutlet weak var newUsernameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var CpwdTextField: UITextField!
    
    var addManu: DatabaseReference!
    
    @IBOutlet weak var typeSegment: UISegmentedControl!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerButton(_ sender: Any) {
       

        //fields are not empty
        
        if(newUsernameTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (passwordTextField.text?.isEmpty)! || (CpwdTextField.text?.isEmpty)!
        {
            displayMessage(userMessage: "All fields are required to fill in")
            return
        }
        
        //validate password
        if ((passwordTextField.text?.elementsEqual(CpwdTextField.text!))! != true)
        {
            displayMessage(userMessage: "Please make sure that passwords match")
            return
        }
        

        let addManu = Database.database().reference().root
        
        let typeSegment1 = typeSegment.selectedSegmentIndex
        
        if emailTextField.text == "" {
            let alertController = UIAlertController(title: "Error", message: "Please enter your email and password", preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(defaultAction)
            
            present(alertController, animated: true, completion: nil)
            
        } else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
                
                if error == nil {
                    self.displayMessage(userMessage:"You have successfully signed up")
                    
                    
                    if(typeSegment1 == 0){
                        addManu.child("users").child((user?.user.uid)!).child("email").setValue(self.emailTextField.text)
                        addManu.child("users").child((user?.user.uid)!).child("type").setValue(0)
                        
                        
                    }
                    else
                    {
                        if(typeSegment1 == 1){
                            
                            addManu.child("users").child((user?.user.uid)!).child("email").setValue(self.emailTextField.text)
                            addManu.child("users").child((user?.user.uid)!).child("type").setValue(1)
                            
                        }
                        else {
                            addManu.child("users").child((user?.user.uid)!).child("email").setValue(self.emailTextField.text)
                            addManu.child("users").child((user?.user.uid)!).child("type").setValue(2)
                            
                        }
                    }
                    
                    
                    
                    
                    self.performSegue(withIdentifier: "segueUp", sender: self)
                    
                    
                } else {
                    let alertController = UIAlertController(title: "Error", message: error?.localizedDescription, preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
                    alertController.addAction(defaultAction)
                    
                    self.present(alertController, animated: true, completion: nil)
                }
            }
        }
        

    }
    
    func isValidEmail(testStr: String)-> Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
    
    let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    let result = emailTest.evaluate(with: testStr)
    return result
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
 

}
