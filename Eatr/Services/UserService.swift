import Alamofire
import Foundation

enum UserService {
    
    private static let baseUrl = "https://eatrapp.herokuapp.com/API/users"
    /*
     Because URLSession runs tasks on a background queue, this method must be asynchronous.
     To process the results, pass in a completion handler.
     This completion handler will be called on the main queue so it can perform UI updates.
     Note that this method only configures a task, it does not start it.
     */
    
    static func isAvailable(username: String, completion: @escaping (Bool?) -> Void) {
        
        let url = URL(string: "\(baseUrl)/checkusername")!
        
        let data = [
            "username": username
        ]
        
        Alamofire.request(url, method: .post, parameters: data).responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                print("Error during request: \(String(describing: response.result.error))")
                completion(nil)
                return
            }
            let json = response.result.value as! NSDictionary
            if (json["username"] as! String) == "ok" {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    static func register(username: String, password: String, completion: @escaping (Bool?) -> Void) {
        let url = URL(string: "\(baseUrl)/register")!
        
        let data = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: data).responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                print("Error during request: \(String(describing: response.result.error))")
                completion(false)
                return
            }
            
            let json = response.result.value as! NSDictionary
            TokenService.save(token: json["token"] as! String, for: username)
            
            completion(true)
        }
    }
    
    static func login(username: String, password: String, completion: @escaping (Bool?) -> Void) {
        let url = URL(string: "\(baseUrl)/login")!
        
        let data = [
            "username": username,
            "password": password
        ]
        
        Alamofire.request(url, method: .post, parameters: data).responseJSON { (response) -> Void in
            guard response.result.isSuccess else {
                print("Error during request: \(String(describing: response.result.error))")
                completion(false)
                return
            }
            
            let json = response.result.value as! NSDictionary
            TokenService.save(token: json["token"] as! String, for: username)
            
            completion(true)
        }
    }
    
    
}
