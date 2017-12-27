import UIKit

class RecipeCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    
    var recipe: Recipe! {
        didSet {
            nameLabel.text = recipe.name
            categoryLabel.text = recipe.category
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)        
    }
}

