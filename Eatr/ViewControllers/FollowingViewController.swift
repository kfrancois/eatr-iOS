import UIKit

class FollowingViewController: UIViewController {

    @IBOutlet weak var token: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        token.text = TokenService.getToken(for: TokenService.username!)
    }
}
