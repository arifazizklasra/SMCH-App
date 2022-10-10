

import UIKit
import Firebase
import JGProgressHUD
import SDWebImage
class MenuViewController: UIViewController {
    var ref: DatabaseReference!
    var items = [Item]()
    @IBOutlet weak var menulist: UITableView!
    private let loader = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference().child("Items")
        
        self.loader.show(in: view, animated: true)
        self.menulist.delegate=self
        self.menulist.dataSource=self
        self.menulist.rowHeight = 100.0
        
        
        ref.observeSingleEvent(of: .value, with: { [self] snapshot in
            self.loader.dismiss(animated: true)

            for child in snapshot.children.allObjects as! [DataSnapshot] {
                
                let singleSnap = child.value as? NSDictionary
                
                let name = singleSnap?["name"] as? String ?? ""
                let desc = singleSnap?["desc"] as? String ?? ""
                let price = singleSnap?["price"] as? Int ?? 0
                let img = singleSnap?["image"] as? String ?? ""

                let item:Item = Item()
                item.name=name
                item.desc=desc
                item.price=price
                item.img=img
                
                self.items.append(item)
                                            
            }

            self.menulist.reloadData()

          }) { error in
          print(error.localizedDescription)
        }
        
    }
}

extension MenuViewController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menulist.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = items[indexPath.row].name
        cell.detailTextLabel?.text = "\(items[indexPath.row].price) AED"
        DispatchQueue.main.async{
            cell.imageView?.sd_setImage(with: URL(string: self.items[indexPath.row].img), placeholderImage: UIImage(named: "placeholder.png"))
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController )!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}

