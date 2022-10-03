

import UIKit
import Firebase
import JGProgressHUD
class ViewController: UIViewController {
    @IBOutlet weak var tf_Email: UITextField!
    private let loader = JGProgressHUD()
    var ref: DatabaseReference!

    @IBOutlet weak var tf_Password: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        if Auth.auth().currentUser != nil {
            
            let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController )!
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
        
        initializeHideKeyboard()
        
    }

    @IBAction func login(_ sender: Any) {
        
        if tf_Email.hasText && tf_Password.hasText
        {
            loader.show(in:view)
            if let email = tf_Email.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = tf_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                    Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
                        
                        
                        self.loader.dismiss(animated: true)
                      if error != nil {
                          let alert = UIAlertController(title: "Failed", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)

                                  // add an action (button)
                                  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                                  // show the alert
                                  self.present(alert, animated: true, completion: nil)
                            return
                      } else {
                          let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MainTabBarController") as? MainTabBarController )!
                          self.navigationController?.pushViewController(vc, animated: true)
                      }
                        
                        
                    }
                
            }
        }else
        {
            let alert = UIAlertController(title: "Failed", message: "Please enter email/password", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }

    }
    
}
extension ViewController {
     func initializeHideKeyboard(){
     //Declare a Tap Gesture Recognizer which will trigger our dismissMyKeyboard() function
     let tap: UITapGestureRecognizer = UITapGestureRecognizer(
     target: self,
     action: #selector(dismissMyKeyboard))
     //Add this tap gesture recognizer to the parent view
     view.addGestureRecognizer(tap)
     }
     @objc func dismissMyKeyboard(){
     //endEditing causes the view (or one of its embedded text fields) to resign the first responder status.
     //In short- Dismiss the active keyboard.
     view.endEditing(true)
     }
 }


