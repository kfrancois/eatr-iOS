import UIKit

class IngredientsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var recipeId = ""
    var ingredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for (index, ingredient) in ingredients.enumerated() {
            if ingredient.checked {
                tableView.selectRow(at: IndexPath(item: index, section: 0), animated: true, scrollPosition: .top)
            }
        }
    }
    
    @IBAction func deselect() {
        for index in 0..<ingredients.count {
            let indexPath = IndexPath(item: index, section: 0)
            tableView.deselectRow(at: indexPath, animated: true)
            
            let cell = tableView.cellForRow(at: indexPath) as! IngredientCell
            cell.accessoryType = UITableViewCellAccessoryType.none
            
            ingredients[index].checked = false
            
            saveIngredients()
        }
    }
    
    @IBAction func back() {
        performSegue(withIdentifier: "didEditIngredients", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "didEditIngredients"?:
            break
        default:
            fatalError("Unknown segue")
        }
    }
}

extension IngredientsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! IngredientCell
        cell.accessoryType = UITableViewCellAccessoryType.checkmark
        ingredients[indexPath.row].checked = true
        saveIngredients()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! IngredientCell
        cell.accessoryType = UITableViewCellAccessoryType.none
        ingredients[indexPath.row].checked = false
        saveIngredients()
    }
    
    func saveIngredients() {
        UserDefaults.standard.set(ingredients.map { $0.checked }, forKey: recipeId)
    }
}

extension IngredientsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let ingredient = ingredients[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
        cell.ingredient = ingredient
        cell.accessoryType = ingredient.checked == true ? UITableViewCellAccessoryType.checkmark : UITableViewCellAccessoryType.none
        return cell
    }

}
