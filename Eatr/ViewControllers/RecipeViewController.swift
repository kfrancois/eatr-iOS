import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var descr: UILabel!
    @IBOutlet weak var stepsContainer: UILabel!
    @IBOutlet weak var ingredientsButton: UIBarButtonItem!
    
    var id: String!
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        RecipeService.recipe(id: id, completion: { completion in
            self.recipe = completion
            self.initializeFields()
        })
    }
    
    func initializeFields() {
        navigationItem.title = recipe.name
        ingredientsButton.isEnabled = true
        
        // TODO fix image resising
        // image.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        // image.translatesAutoresizingMaskIntoConstraints = true
        imageView.contentMode = UIViewContentMode.scaleAspectFit
        let image = UIImage(data: recipe.image)
        imageView.image = image
        
        let height = (imageView.frame.width / (image?.size.width)!) * (image?.size.height)!
        
        
        let imageViewWidthConstraint = NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: (image?.size.width)!)
        let imageViewHeightConstraint = NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: height)
        imageView.addConstraints([imageViewWidthConstraint, imageViewHeightConstraint])
        
        people.text = "\(recipe.people) \(recipe.people.intValue > 1 ? "people" : "person")"
        time.text = recipe.time
        descr.text = recipe.description
        
        let savedIngredients = UserDefaults.standard.array(forKey: recipe.id)
        if savedIngredients != nil {
            for i in 0..<recipe.ingredients.count {
                let checked = savedIngredients![i] as! Bool
                recipe.ingredients[i].checked = checked
            }
        }
        
        var text = ""
        var i = 1
        for step in recipe.steps {
            text += "\(i)\n\(step)\n\n"
            i += 1
        }
        
        stepsContainer.text = text
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showIngredients"?:
            let ingredientsViewController = (segue.destination as! UINavigationController).topViewController as! IngredientsViewController
            ingredientsViewController.recipeId = recipe.id
            ingredientsViewController.ingredients = recipe.ingredients
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func unwindFromIngredients(_ segue: UIStoryboardSegue) {
        switch segue.identifier {
        case "didEditIngredients"?:
            let ingredientsViewController = segue.source as! IngredientsViewController
            self.recipe.ingredients = ingredientsViewController.ingredients
        default:
            fatalError("Unkown segue")
        }
    }

    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
}
