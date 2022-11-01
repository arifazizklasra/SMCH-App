//
//  CartController.swift
//  SMCH App
//
//  Created by Arif Aziz on 13/10/2022.
//

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage
class CartController: UIViewController {
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var scooking: UISwitch!
    @IBOutlet weak var cartlist: UITableView!
    @IBOutlet weak var scleaning: UISwitch!
    @IBOutlet weak var scuttling: UISwitch!
    var ref: DatabaseReference!
    var items = [CartItem]()
    var total:Int = 0
    private let loader = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        guard let userID = Auth.auth().currentUser?.uid else { return }
        ref = Database.database().reference().child("Cart").child(userID)
        
        self.loader.show(in: view, animated: true)
        self.cartlist.delegate=self
        self.cartlist.dataSource=self
        self.cartlist.rowHeight = 100.0
        
        
        
        ref.observe(DataEventType.value, with: { [self] snapshot in
                
            self.loader.dismiss(animated: true)
            items.removeAll()
            total=10
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let singleSnap = child.value as? NSDictionary
                
                let name = singleSnap?["name"] as? String ?? ""
                let weight = singleSnap?["weight"] as? Int ?? 0
                let price = singleSnap?["price"] as? Int ?? 0
                let img = singleSnap?["img"] as? String ?? ""

                let item:CartItem = CartItem()
                item.name=name
                item.weight=weight
                item.price=price
                item.img=img
                total+=price
                self.items.append(item)
                                            
            }
            
            totalPrice.text = "Total : \(total) AED"
            
            self.cartlist.reloadData()

          }) { error in
          print(error.localizedDescription)
        }
        
    }
    @IBAction func acooking(_ sender: Any) {
        if scooking.isOn
        {
            total+=20
            totalPrice.text = "Total : \(total) AED"
        }else
        {
            total-=20
            totalPrice.text = "Total : \(total) AED"
        }
    }
    @IBAction func acuttling(_ sender: Any) {
        if scuttling.isOn
        {
            total+=7
            totalPrice.text = "Total : \(total) AED"
        }else
        {
            total-=7
            totalPrice.text = "Total : \(total) AED"
        }
    }
    @IBAction func acleaning(_ sender: Any) {
        if scleaning.isOn
        {
            total+=10
            totalPrice.text = "Total : \(total) AED"
        }else
        {
            total-=10
            totalPrice.text = "Total : \(total) AED"
        }
    }
    
    @IBAction func confirmOrder(_ sender: Any) {
    }
}
    

extension CartController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = cartlist.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = "\(items[indexPath.row].price) AED"
        DispatchQueue.main.async{
            cell.imageView?.sd_setImage(with: URL(string: self.items[indexPath.row].img), placeholderImage: UIImage(named: "placeholder.png"))
                }
        return cell
    }
    
    
}

