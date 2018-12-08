

import Foundation

enum Key: String {
    case apiKey = "Your Api key"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]
}

extension Endpoint {
    static func searchImage(with name: String, page: Int, apiKey: Key = .apiKey) -> Endpoint {
        return Endpoint(
            path: "/api/",
            queryItems: [
                URLQueryItem(name: "key", value: apiKey.rawValue),
                URLQueryItem(name: "q", value: name),
                URLQueryItem(name: "image_type", value: "all"),
                URLQueryItem(name: "page", value: String(page)),
                URLQueryItem(name: "pretty", value: "true")
            ]
        )
    }
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "pixabay.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}
