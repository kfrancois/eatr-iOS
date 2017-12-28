import UIKit

class IngredientsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var ingredients: [Ingredient] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func back() {
        dismiss(animated: true, completion: nil)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "ingredientCell", for: indexPath) as! IngredientCell
        cell.ingredient = ingredients[indexPath.row]
        return cell
    }
}
