import UIKit

class RecipeViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var people: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var descr: UILabel!
    
    var recipe: Recipe!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = recipe.name
        
        do {
            let data = try? Data(contentsOf: URL(string: recipe.image)!)
            if data != nil {
                image.image = UIImage(data: data!)
            }
        }
        people.text = "\(recipe.people) people"
        time.text = recipe.time
        descr.text = recipe.description
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showIngredients"?:
            let ingredientsViewController = (segue.destination as! UINavigationController).topViewController as! IngredientsViewController
            ingredientsViewController.ingredients = recipe.ingredients
        default:
            fatalError("Unknown segue")
        }
    }

    @IBAction func back() {
        dismiss(animated: true, completion: nil)
    }
}
