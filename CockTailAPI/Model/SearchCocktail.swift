import Foundation

struct CockTailResponse: Codable {
    let drinks: [Drink]
}

struct Drink: Codable {
    let drinkName: Int
    let category: String?
    let drinkImg: URL
    
    enum CodingKeys: String, CodingKey {
        case drinkName = "strDrink"
        case category = "strCategory"
        case drinkImg = "strDrinkThumb"
    }
}
