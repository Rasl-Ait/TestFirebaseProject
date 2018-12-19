

import Foundation

protocol GenericAPIClient {
    var session: URLSession { get }
    func fetch<T :Decodable> (with request: URLRequest,
                              type: T.Type,
                              completion: @escaping ItemClosure<Result<T, DataResponseError>>)
}

extension GenericAPIClient {
    func fetch<T : Decodable> (with request: URLRequest,
                               type: T.Type,
                               completion: @escaping ItemClosure<Result<T, DataResponseError>>) {
        
        let task =  session.dataTask(with: request) { data, response, error in
            
            guard
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.hasSuccessStatusCode,
                let data = data
                else {
                    completion(Result.failure(DataResponseError.network))
                    return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            guard let decodedResponse = try? decoder.decode(T.self, from: data) else {
                completion(Result.failure(DataResponseError.decoding))
                return
            }
            
            completion(Result.success(decodedResponse))
        }
        task.resume()
    }
}


