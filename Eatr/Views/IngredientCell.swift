import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var ingredient: Ingredient! {
        didSet {
            nameLabel.text = ingredient.name
            descriptionLabel.text = ingredient.amount != 0 ? "\(ingredient.amount) \(ingredient.unit)" : "\(ingredient.unit)"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


