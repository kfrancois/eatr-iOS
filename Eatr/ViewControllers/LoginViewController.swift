import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    @IBAction func login() {
        UserService.login(username: usernameField.text!, password: passwordField.text!, completion: { result in
            if result! {
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.present(mainViewController, animated: true, completion: nil)
            }
        })
    }

}

