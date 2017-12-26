import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    @IBAction func login() {
        UserService.isAvailable(username: usernameField.text!, completion: { result in
            self.passwordField.text = (result)! ? "success" : "fail"
        })
    }

}

