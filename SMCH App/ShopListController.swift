

import UIKit

class ShopListController: UIViewController {
    @IBOutlet weak var TBShopslist: UITableView!
    let counters = ["Counter M001","Counter M002","Counter M003","Counter M004","Counter M005","Counter M006","Counter M007","Counter M008","Counter M009","Counter M010","Counter M011","Counter M012","Counter M013","Counter M014","Counter M015"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TBShopslist.delegate = self
        TBShopslist.dataSource = self
        
    }
    

}

extension ShopListController : UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return counters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = TBShopslist.dequeueReusableCell(withIdentifier: "countercell", for: indexPath)
        cell.textLabel?.text = counters[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "MenuViewController") as? MenuViewController )!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
