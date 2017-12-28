import UIKit

class IngredientCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    
    var ingredient: Ingredient! {
        didSet {
            nameLabel.text = ingredient.name
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


