import SwiftyJSON
import Foundation

struct Ingredient {
    let name: String
    let amount: NSNumber
    let unit: String
}

extension Ingredient {
    static func fromJSON(json: JSON) -> Ingredient {
        return Ingredient(name: "test", amount: 5, unit: "kg")
    }
}
