
import Foundation

class PixabayClient: GenericAPIClient {
    
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    func fetchSearchImage(with endpoint: Endpoint,
                          completion: @escaping ItemClosure<Result<HitImage, DataResponseError>>){
        let urlRequest = URLRequest(url: endpoint.url!)
        fetch(with: urlRequest, type: HitImage.self) { result in
            completion(result)
        }
    }
}
