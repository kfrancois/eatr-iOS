import UIKit

class FollowingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var recipes: [Recipe] = []
    
    override func viewDidLoad() {
        RecipeService.subscribedRecipes { completion in
            self.recipes = completion != nil ? completion! : []
            self.tableView.reloadData()
        }
        // splitViewController!.delegate = self
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

/*
extension FollowingViewController: UISplitViewControllerDelegate {
    func collapseSecondaryViewController(_ secondaryViewController: UIViewController, for splitViewController: UISplitViewController) -> Bool {
        let isShowingTasks = (secondaryViewController as! UINavigationController).topViewController is TasksViewController
        
        // if task is shown: dont collapse
        return !isShowingTasks
    }
}
*/
