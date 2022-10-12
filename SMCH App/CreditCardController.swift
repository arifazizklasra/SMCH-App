

import UIKit

class CreditCardController: UIViewController {
    @IBOutlet weak var cardnum: UITextField!

    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var cvv: UITextField!
    @IBOutlet weak var expirydate: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func payNow(_ sender: Any) {
        
        
        if cardnum.hasText && address.hasText && cvv.hasText && expirydate.hasText
        {
            
            
            if cardnum.text?.count == 10
            {
                let vc:UIViewController = (self.storyboard?.instantiateViewController(withIdentifier: "FinalScreenController") as? FinalScreenController )!
                self.navigationController?.pushViewController(vc, animated: true)
                
            }else
            {
                let alert = UIAlertController(title: "Validation Failed", message: "There must be 10 numbers for Credit Card", preferredStyle: UIAlertController.Style.alert)

                        // add an action (button)
                        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                        // show the alert
                        self.present(alert, animated: true, completion: nil)
            }
            
        }else
        {
            let alert = UIAlertController(title: "Validation Failed", message: "Please provide all information require", preferredStyle: UIAlertController.Style.alert)

                    // add an action (button)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))

                    // show the alert
                    self.present(alert, animated: true, completion: nil)
        }
    }
}
