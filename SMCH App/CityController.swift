
import UIKit

class CityController: UIViewController {
    @IBOutlet weak var TBShopslist: UITableView!
    let counters = ["Abu Dhabi","Dubai","Sharjah","Ajman","Ras Al Khaimah","Fujairah"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        TBShopslist.delegate = self
        TBShopslist.dataSource = self
        
    }
    

}

extension CityController : UITableViewDelegate, UITableViewDataSource
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
        
        let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "ShopListController") as? ShopListController )!
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
