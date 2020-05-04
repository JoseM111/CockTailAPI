import Foundation

enum DrinkError: LocalizedError {
    case invalidURL
    case thrownError(Error)
    case noData
    case unableToDecode
    
    // Give the user whatever information you think they should know. Feel free to write your own descriptions.
    var errorDescription: String? {
        switch self {
            case .invalidURL:
                return "Internal error. Enter correct URL or contact support."
            case .thrownError(let error):
                return error.localizedDescription
            case .noData:
                return "The server responded with no data."
            case .unableToDecode:
                return "Could not DECODE.. Bad data."
        }
    }
}

