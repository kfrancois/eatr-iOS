import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var statusLabel: UILabel!

    @IBAction func register() {
        let passwordLength = (passwordField.text?.count)!
        if passwordLength < 8 {
            self.statusLabel.text = "Password too short \(passwordLength)/8"
            self.statusLabel.isHidden = false
            return
        }
        
        if passwordField.text != confirmPasswordField.text {
            self.statusLabel.text = "Passwords do not match"
            self.statusLabel.isHidden = false
            return
        }
        
        UserService.isAvailable(username: usernameField.text!, completion: { result in
            if !(result)! {
                self.statusLabel.text = "Username taken"
                self.statusLabel.isHidden = false
                return
            }
            else {
                //TODO register
                self.statusLabel.text = "Registering..."
                
                UserService.register(username: self.usernameField.text!, password: self.passwordField.text!,
                                     completion: { registerResult in
                    if registerResult! {
                        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                        let mainViewController = storyBoard.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                        self.present(mainViewController, animated: true, completion: nil)
                    }
                })
            }
        })
    }
}
