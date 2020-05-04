import Foundation
import UIKit.UIImage

class SearchModelController {
    
    // MARK: _@Magic-String 🧙🏾‍♂️
    // Full URL:-->https://www.thecocktaildb.com/api/json/v1/1/search.php?f=a
    static let baseURL = URL(string: "https://www.thecocktaildb.com/api/json/v1/1/")
    static let pathSearchComponent = "search.php"
    static let apiKey = "f"
    static let apiValue = "a"
    
    // MARK: _@fetchCocktail
    /**©------------------------------------------------------------------------------©*/
    static func fetchCocktail(for searchName: String, completion: @escaping (Result<Drink, DrinkError>) -> Void) {
        
        // 1) - URL
        guard let baseURL = baseURL else { return completion(.failure(.invalidURL)) }
        
        /// Appending our component
        let searchComponent = baseURL.appendingPathComponent(pathSearchComponent)
        var urlComponent = URLComponents(url: searchComponent, resolvingAgainstBaseURL: true)
        /// Add api key & value
        let drinkQueryItems = URLQueryItem(name: apiKey, value: apiValue)
        
        urlComponent?.queryItems = [drinkQueryItems]
        
        /// add the full url & print to see it completes successfully
        guard let fullURL = urlComponent?.url else { return completion(.failure(.invalidURL)) }
        divT("Full URL")
        printf(fullURL)
        
        // 2) - Data-Task
        /**©-----------------------------©*/
        URLSession.shared.dataTask(with: fullURL) { (data, _, error) in
            
            // 3) - Error-Handling
            if let error = error {
                printf("[ERROR].. \(error)-->> \(error.localizedDescription)")
                return completion(.failure(.thrownError(error)))
            }
            
            // 4) - Check for Data
            guard let data = data else {
                printf("[ERROR].. No data..")
                return completion(.failure(.noData))
            }
            
            // 5) - Decode-Data
            let jsonDecoder = JSONDecoder()
            
            do {
                let drinkCallBack = try jsonDecoder.decode(Drink.self, from: data)
                completion(.success(drinkCallBack))
            } catch {
                printf("YOU DONE DID IT NOW JOSE!!! \(error) \(error.localizedDescription)")
            }
        }.resume()
        /**©-----------------------------©*/
    }/// END OF FUNCTION
    /**©------------------------------------------------------------------------------©*/
    static func fetchCocktailImage(for cocktail: Drink, completion: @escaping (Result<UIImage, DrinkError>) -> Void) {
        
        // 1) - Get our image property(NOTE: Has to be a URL)
        let drinkImgURL: URL = cocktail.drinkImg
        
        // 2) - Data-Task
        URLSession.shared.dataTask(with: drinkImgURL) { (data, _, error) in
            
            // 3) - Error-Handling
            if let error = error {
                printf("[ERROR].. \(error)-->> \(error.localizedDescription)")
                return completion(.failure(.invalidURL))
            }
            
            // 4) - Check for Data
            guard let data = data else { return completion(.failure(.noData)) }
            
            // 5) - Check for Image
            guard let image = UIImage(data: data) else { return completion(.failure(.noData)) }
            return completion(.success(image))
            
        }.resume()
    }/// END OF FUNCTION
    /**©------------------------------------------------------------------------------©*/
}// END OF CLASS
