
import Foundation

enum Result<T, U> where U: Error  {
	case success(T)
	case failure(U)
}

enum DataResponseError: LocalizedError {
	case network
	case decoding
	
	var reason: String {
		switch self {
		case .network:
			return NSLocalizedString("An error occurred while fetching data", comment: "")
		case .decoding:
			return NSLocalizedString("An error occurred while decoding data", comment: "")
		}
	}
}
