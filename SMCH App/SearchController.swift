
import UIKit
import Firebase
import JGProgressHUD
import SDWebImage
class SearchController: UIViewController, UISearchBarDelegate {
    var ref: DatabaseReference!
    var items = [Item]()
    var filtereditems = [Item]()
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var menulist: UITableView!
    private let loader = JGProgressHUD()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference().child("Items")
        
        self.loader.show(in: view, animated: true)
        self.menulist.delegate=self
        self.menulist.dataSource=self
        self.searchBar.delegate=self
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
            filtereditems = items
            self.menulist.reloadData()

          }) { error in
          print(error.localizedDescription)
        }
        
    }
}

extension SearchController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtereditems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = menulist.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filtereditems[indexPath.row].name
        cell.detailTextLabel?.text = "\(filtereditems[indexPath.row].price) AED"
        DispatchQueue.main.async{
            cell.imageView?.sd_setImage(with: URL(string: self.filtereditems[indexPath.row].img), placeholderImage: UIImage(named: "placeholder.png"))
                }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController )!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtereditems = [Item]()
        if searchText.isEmpty
        {
            filtereditems = items
        }else
        {
            for item in items
            {
                if item.name.lowercased().contains(searchText.lowercased())
                {
                    filtereditems.append(item)
                }
            }
            
        }
        
        menulist.reloadData()
    }
    
    
}

