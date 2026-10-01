import Foundation

enum APIConfiguration {
    static let scheme = "http"
    static let host: String = {
        guard let host = Bundle.main.object(forInfoDictionaryKey: "API_HOST") as? String,
              !host.isEmpty else {
            preconditionFailure("API_HOST is missing from Info.plist")
        }
        return host
    }()
    static let port: Int = 8000
    static let path = ""

    static func url(path: String) -> URL {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.port = port
        components.path = path
        return components.url!
    }
}