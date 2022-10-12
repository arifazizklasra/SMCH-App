//
//  DetailViewController.swift
//  SMCH App
//
//  Created by Arif Aziz on 08/10/2022.
//

import UIKit
import Firebase

class DetailViewController: UIViewController {
    var ref: DatabaseReference!

    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var weight: UILabel!
    @IBOutlet weak var des: UILabel!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var name: UILabel!
    static var item:Item?
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        name.text = DetailViewController.item?.name
        des.text = DetailViewController.item?.desc
        
        DispatchQueue.main.async{ [self] in
            img.sd_setImage(with: URL(string: DetailViewController.item!.img), placeholderImage: UIImage(named: "placeholder.png"))
                }
    }
    
    @IBAction func addtocart(_ sender: Any) {
        guard let userID = Auth.auth().currentUser?.uid else { return }
        self.ref.child("Cart").child(userID).childByAutoId().setValue(["name": DetailViewController.item?.name, "desc": DetailViewController.item?.desc, "price": (Double(DetailViewController.item!.price) * stepper.value), "weight": stepper.value, "img": DetailViewController.item?.img])
        
        let alert = UIAlertController(title: "Success", message: "Your items have been added to cart successfully", preferredStyle: UIAlertController.Style.alert)

                // add an action (button)
                alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                // show the alert
                self.present(alert, animated: true, completion: nil)
      
    }
    
    @IBAction func stepperAction(_ sender: Any) {
        weight.text = "\(Int(stepper.value)) Kg"
    }
}
