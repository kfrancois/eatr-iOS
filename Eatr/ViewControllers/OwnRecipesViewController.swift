import UIKit

class OwnRecipesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        refreshTable()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showRecipe"?:
            let recipeViewController = (segue.destination as! UINavigationController).topViewController as! RecipeViewController
            let selection = tableView.indexPathForSelectedRow!
            recipeViewController.id = recipes[selection.row].id
            tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func refreshTable() {
        RecipeService.ownRecipes { completion in
            self.recipes = completion != nil ? completion! : []
            self.tableView.reloadData()
        }
    }
}

extension OwnRecipesViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return recipes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "recipeCell", for: indexPath) as! RecipeCell
        cell.recipe = recipes[indexPath.row]
        return cell
    }
}


