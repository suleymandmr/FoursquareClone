//
//  ViewController.swift
//  FoursquareClone
//
//  Created by eyüp yaşar demir on 1.06.2023.
//

import UIKit
import Parse

class SignUpVC: UIViewController {

    
    @IBOutlet weak var userNameText: UITextField!
    
    @IBOutlet weak var passwordText: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*let parseObject = PFObject(className: "Fruits")
        parseObject["name"] = "Banana"
        parseObject["calories"] = 150
        parseObject.saveInBackground { success, error in
            if error != nil {
                print(error?.localizedDescription)
                
            }else{
                print("uploaded")
            }
        }
        
        let query = PFQuery(className: "Fruits")
        query.whereKey("name", equalTo: "Apple")
        query.whereKey("calories", greaterThan: 120)
        query.findObjectsInBackground { object, error in
            if error != nil {
                print(error?.localizedDescription)
            }else{
                print(object)
            }
        }*/
        
    }

    @IBAction func singInClicked(_ sender: Any) {
        if userNameText.text != "" && passwordText.text != "" {
            
        PFUser.logInWithUsername(inBackground: userNameText.text!, password: passwordText.text!) { user, error in
                if error != nil{
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                }else{
                    
                    self.performSegue(withIdentifier: "toPlacesVC", sender: nil )
                    
                }
            }
            
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username / Password??")
        }
        
    }
    
    
    @IBAction func singUpClicked(_ sender: Any) {
        
        if userNameText.text != "" && passwordText.text != "" {
            let user = PFUser()
            user.username = userNameText.text!
            user.password = passwordText.text!
            
            user.signUpInBackground { (success, error) in
                if error != nil {
                    self.makeAlert(titleInput: "Error", messageInput: error?.localizedDescription ?? "Error!")
                }else{
                    // segue
                    print("ok")
                }
            }
        }else{
            makeAlert(titleInput: "Error", messageInput: "Username / Password??")
        }
        
    }
    
    func makeAlert(titleInput: String, messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
   

}

