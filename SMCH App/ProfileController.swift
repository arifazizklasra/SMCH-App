//
//  ProfileController.swift
//  SMCH App
//
//  Created by Arif Aziz on 08/10/2022.
//

import UIKit
import Firebase
class ProfileController: UIViewController {
    var ref: DatabaseReference!
    
    @IBOutlet weak var tf_address: UILabel!
    @IBOutlet weak var tf_phone: UILabel!
    @IBOutlet weak var tf_name: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
        
        guard let userID = Auth.auth().currentUser?.uid else { return }
        
        ref.child("Users").child(userID).observeSingleEvent(of: .value, with: { snapshot in
          // Get user value
            let value = snapshot.value as? NSDictionary
            let name = value?["name"] as? String ?? ""
            let phone = value?["phone"] as? String ?? ""
            let address = value?["address"] as? String ?? ""
            
            self.tf_name.text=name
            self.tf_phone.text=phone
            self.tf_address.text=address
            
            
        }) { error in
          print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    @IBAction func signout(_ sender: Any) {
        do { try Auth.auth().signOut() }
        catch { print("already logged out") }
        
        navigationController?.popToRootViewController(animated: true)
        
    }

}
