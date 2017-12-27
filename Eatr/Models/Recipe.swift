import Foundation
import SwiftyJSON

struct Recipe {
    let id: String
    let name: String
    /* let user: User */
    let people: NSNumber
    let category: String
    let image: String
    let description: String
    let time: String
    let steps: [String]
    let ingredients: [Ingredient]
}

extension Recipe {
    static func fromJSON(json: JSON) -> Recipe {
        let id = json["_id"].stringValue
        let name = json["name"].stringValue
        let people = json["people"].numberValue
        let category = json["category"].stringValue
        let image = json["image"].stringValue
        let description = json["description"].stringValue
        let time = json["time"].stringValue
        let steps = json["steps"].arrayValue.map { $0.stringValue }
        // TODO add ingredients from json
        
        return Recipe(id: id, name: name, people: people, category: category, image: image, description: description, time: time, steps: steps, ingredients: [])
    }
}
