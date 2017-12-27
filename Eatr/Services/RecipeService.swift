import Alamofire
import Foundation
import SwiftyJSON

enum RecipeService {
    
    private static let baseUrl = "https://eatrapp.herokuapp.com/API"
    /*
     Because URLSession runs tasks on a background queue, this method must be asynchronous.
     To process the results, pass in a completion handler.
     This completion handler will be called on the main queue so it can perform UI updates.
     Note that this method only configures a task, it does not start it.
     */
    
    static func subscribedRecipes(completion: @escaping ([Recipe]?) -> Void) {
        
        let url = URL(string: "\(baseUrl)/recipes/following")!
        
        guard TokenService.token != nil else {
            print("Error during request: No token")
            completion(nil)
            return
        }
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer \(TokenService.token!)",
            "Accept": "application/json"
        ]
        
        Alamofire.request(url, method: .get, headers: headers).responseData { (response) -> Void in
            guard response.result.isSuccess else {
                print("Error during request: \(String(describing: response.result.error))")
                
                print(response)
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            let recipes = json.map { Recipe.fromJSON(json: $1) }
            
            completion(recipes)
        }
    }
}
