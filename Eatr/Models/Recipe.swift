import Foundation
import SwiftyJSON

struct Recipe {
    let id: String
    let name: String
    /* let user: User */
    let people: NSNumber
    let category: String
    let image: Data
    let description: String
    let time: String
    let steps: [String]
    var ingredients: [Ingredient]
}

extension Recipe {
    static func fromJSON(json: JSON) -> Recipe {
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let people = json["people"].numberValue
        let category = json["category"].stringValue
        var image: Data
        do {
            image = try Data(contentsOf: URL(string: json["image"].stringValue)!)
        } catch { // Default image
            image = try! Data(contentsOf: URL(string: "https://eatrapp.herokuapp.com/assets/noimage.png")!)
        }
        let description = json["description"].stringValue
        let time = json["time"].stringValue
        let steps = json["steps"].arrayValue.map { $0.stringValue }
        let ingredients =  json["ingredients"].arrayValue.map { Ingredient.fromJSON(json: $0)}
        
        return Recipe(id: id, name: name, people: people, category: category, image: image, description: description, time: time, steps: steps, ingredients: ingredients)
    }
}
