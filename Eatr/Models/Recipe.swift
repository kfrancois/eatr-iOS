import Foundation

struct Recipe {
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
