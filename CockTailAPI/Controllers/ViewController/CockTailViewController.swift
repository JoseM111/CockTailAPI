import UIKit

class CockTailViewController: UIViewController {
    
    // MARK: _@IBOutlet
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var cockTailImage: UIImageView!
    @IBOutlet weak var drinkNameLabel: UILabel!
    @IBOutlet weak var categoryNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
    }
    
    // MARK: _@Methods binding our outlets with our models properties
    func fetchCockTailAndUpdateUI(for cocktail: Drink) {
        
        SearchModelController.fetchCocktailImage(for: cocktail) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let image):
                        self.cockTailImage.image = image
                        self.drinkNameLabel.text = "\(cocktail.drinkName)"
                        self.categoryNameLabel.text = cocktail.category
                    case .failure(let error):
                        self.userErrorAlert(localizedError: error)
                }
            }
        }
    }
}// END OF CLASS
/**©------------------------------------------------------------------------------©*/
extension CockTailViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        guard let searchTerm = searchBar.text, !searchTerm.isEmpty else { return }
        SearchModelController.fetchCocktail(for: searchTerm) { (result) in
            
            DispatchQueue.main.async {
                switch result {
                    case .success(let cocktail):
                        self.fetchCockTailAndUpdateUI(for: cocktail)
                    case .failure(let error):
                        self.userErrorAlert(localizedError: error)
                }
            }
        }
    }
}
/**©------------------------------------------------------------------------------©*/

