import Foundation

public enum HTTPError: Error {
    case error(String), parse(String), status(Int), decode
}

public enum HTTPMethod: String {
    case get = "GET", post = "POST", put = "PUT", patch = "PATCH", delete = "DELETE"
}

extension URL {
    public func appendingQueryItems(_ items: [URLQueryItem]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: false)!
        components.queryItems = items
        return components.url!
    }
}

public class API {
    public var baseURL: URL
    
    private var encoder = JSONEncoder()
    private var decoder = JSONDecoder()
    
    public init(baseURL: URL = URL(string: "https://api.vitruvian.me/")!) {
        self.baseURL = baseURL
    }

    private func request(_ path: String, method: HTTPMethod, params: [String: String] = [:]) -> URLRequest {
        var request = URLRequest(
            url: baseURL
                    .appendingPathComponent(path)
                    .appendingQueryItems(params.map { URLQueryItem(name: $0, value: $1) })
        )
        
        request.httpMethod = method.rawValue
        
        var appVersion: String {
            Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
        }
        
        var buildNumber: String {
            Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""
        }

        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Vitruvian iOS \(appVersion) (\(buildNumber))", forHTTPHeaderField: "User-Agent")

        return request
    }
    
    private func fetch<T: Codable>(_ request: URLRequest) async throws -> T {
        let (data, response) = try await URLSession.shared.data(for: request) as! (Data, HTTPURLResponse)
        
        guard 200..<300 ~= response.statusCode else {
            throw HTTPError.status(response.statusCode)
        }
        
        return try self.decoder.decode(T.self, from: data)
    }
    
    private func fetch<T: Codable>(_ path: String, query: [String: String] = [:]) async throws -> T {
        return try await self.request(.get, path, query: query)
    }
    
    private func request<T: Codable>(_ method: HTTPMethod, _ path: String, query: [String: String] = [:]) async throws -> T {
        return try await self.fetch(self.request(path, method: method, params: query))
    }

    public func fetchExercises() async throws -> [Exercise] {
        return try await self.fetch("/v1/exercises")
    }
}
