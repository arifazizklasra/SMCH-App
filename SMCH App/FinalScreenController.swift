//
//  FinalScreenController.swift
//  SMCH App
//
//  Created by Arif Aziz on 13/10/2022.
//

import UIKit
import Firebase
class FinalScreenController: UIViewController {
    var ref: DatabaseReference!

    @IBOutlet weak var finaltext: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        
        finaltext.text = "Thank you for buying with us !"
        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.ref.child("Cart").child(userID).removeValue()

    }
}
