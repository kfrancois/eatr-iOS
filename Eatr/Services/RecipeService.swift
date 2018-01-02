import Alamofire
import Foundation
import SwiftyJSON

enum RecipeService {
    
    private static let baseUrl = "https://eatrapp.herokuapp.com/API"
    
    static func recipe(id: String, completion: @escaping (Recipe?) -> Void) {
        
        let url = URL(string: "\(baseUrl)/recipe/\(id)")!
        
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
                
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            completion(Recipe.fromJSON(json: json))
        }
    }
    
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
                
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            let recipes = json.map { Recipe.fromJSON(json: $1) }
            
            completion(recipes)
        }
    }
    
    static func allRecipes(completion: @escaping ([Recipe]?) -> Void) {
        
        let url = URL(string: "\(baseUrl)/recipes/all")!
        
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
                
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            let recipes = json.map { Recipe.fromJSON(json: $1) }
            
            completion(recipes)
        }
    }

    static func ownRecipes(completion: @escaping ([Recipe]?) -> Void) {
        
        let url = URL(string: "\(baseUrl)/recipes")!
        
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
                
                completion(nil)
                return
            }
            
            let json = JSON(response.result.value!)
            
            let recipes = json.map { Recipe.fromJSON(json: $1) }
            
            completion(recipes)
        }
        
    }
}
