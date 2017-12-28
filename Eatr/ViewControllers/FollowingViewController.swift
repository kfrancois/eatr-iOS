import UIKit

class FollowingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        refreshTable()
        // splitViewController!.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch  segue.identifier {
        case "showRecipe"?:
            let recipeViewController = (segue.destination as! UINavigationController).topViewController as! RecipeViewController
            let selection = tableView.indexPathForSelectedRow!
            recipeViewController.recipe = recipes[selection.row]
            tableView.deselectRow(at: selection, animated: true)
        default:
            fatalError("Unknown segue")
        }
    }
    
    @IBAction func refreshTable() {
        RecipeService.subscribedRecipes { completion in
            self.recipes = completion != nil ? completion! : []
            self.tableView.reloadData()
        }
    }
}

extension FollowingViewController: UITableViewDataSource {
    
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
