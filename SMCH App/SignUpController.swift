

import UIKit
import JGProgressHUD
import Firebase
class SignUpController: UIViewController {

    let emirates = ["Abu Dhabi","Dubai","Sharjah","Ajman","Ras Al Khaimah","Fujairah"]
    
    var pickerview = UIPickerView()
    
    private let loader = JGProgressHUD()
    var ref: DatabaseReference!
    
    @IBOutlet weak var tf_Email: UITextField!
    @IBOutlet weak var tf_Password: UITextField!
    @IBOutlet weak var tf_name: UITextField!
    @IBOutlet weak var tf_address: UITextField!
    @IBOutlet weak var tf_phone: UITextField!
    
    @IBOutlet weak var tf_emarite: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        initializeHideKeyboard()
        
        pickerview.delegate = self
        pickerview.dataSource = self
        
        tf_emarite.inputView = pickerview

    }
    
    
    @IBAction func signup(_ sender: Any) {
        
        if tf_Email.hasText && tf_Password.hasText
        {
            loader.show(in:view)
            if let email = tf_Email.text?.trimmingCharacters(in: .whitespacesAndNewlines), let password = tf_Password.text?.trimmingCharacters(in: .whitespacesAndNewlines) {
                Auth.auth().createUser(withEmail: email, password: password) { [self] (authResult, error) in
                        
                        
                        self.loader.dismiss(animated: true)
                      if error != nil {
                          let alert = UIAlertController(title: "Failed", message: error?.localizedDescription, preferredStyle: UIAlertController.Style.alert)

                                  // add an action (button)
                                  alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                                  // show the alert
                                  self.present(alert, animated: true, completion: nil)
                            return
                      } else {
                          
                          guard let userID = Auth.auth().currentUser?.uid else { return }

                          self.ref.child("Users").child(userID).setValue(["name": tf_name.text!, "address": tf_address.text!, "uid": userID, "phone": tf_phone.text!, "email": tf_Email.text!, "emarite": tf_emarite.text!])
                          
                          let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "OTPController") as? OTPController )!
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


extension SignUpController : UIPickerViewDelegate,UIPickerViewDataSource
{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return emirates.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return emirates[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tf_emarite.text = emirates[row]
    }
    
    
}




extension SignUpController {
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
