import SwiftyJSON
import Foundation

struct Ingredient {
    let name: String
    let amount: NSInteger
    let unit: String
}

extension Ingredient {
    static func fromJSON(json: JSON) -> Ingredient {
        let name = json["name"].stringValue
        let amount = json["amount"].intValue
        let unit = json["unit"].stringValue
        
        return Ingredient(name: name, amount: amount, unit: unit)
    }
}
