import Foundation
import Combine

protocol APIServiceProtocol {
    func fetchData(
        _ link: String,
        method: HTTPMethod,
        parameters: Any?
    ) -> AnyPublisher<Data, HTTPError>
}

final class APIService: APIServiceProtocol {
    
    private let session: URLSession = .shared
    
    let prot = Storage.shared.prot
    
    
    func fetchData(
        _ link: String,
        method: HTTPMethod = .get,
        parameters: Any? = nil
    ) -> AnyPublisher<Data, HTTPError> {
        
        guard let url = URL(string: link) else {
            return Fail(error: .networkError(URLError(.badURL))).eraseToAnyPublisher()
        }
        var request = URLRequest(url: url)
        setParameters(&request, parameters: parameters)
        request.httpMethod = method.rawValue
        request.timeoutInterval = 30
        request.setValue(Storage.shared.token, forHTTPHeaderField: "x-access-token")
        return session.dataTaskPublisher(for: request)// URLResponse + data
            .assumeHTTP() // HTTPURLResponse + data
            .responseData() // Data
            .eraseToAnyPublisher()
    }
    
    private func setParameters(
        _ request_: inout URLRequest,
        parameters: Any?
    ) {
        if let parameters = parameters {
            do {
                request_.httpBody = try JSONSerialization.data(
                    withJSONObject: parameters,
                    options: .prettyPrinted
                )
            } catch {
                print("error_add_parameters: \(error.localizedDescription)")
            }
        }
    }
}


extension Publisher where Output == (data: Data, response: URLResponse) {
    
    func assumeHTTP() -> AnyPublisher<(data: Data, response: HTTPURLResponse), HTTPError> {
        tryMap { (data: Data, response: URLResponse) in
            guard let http = response as? HTTPURLResponse else { throw HTTPError.nonHTTPResponse }
            return (data, http)
        }
        .mapError { error in
            if let httpError = error as? HTTPError {
                return httpError
            } else {
                return HTTPError.networkError(error)
            }
        }
        .eraseToAnyPublisher()
    }
}


extension Publisher where Output == (data: Data, response: HTTPURLResponse), Failure == HTTPError {
    
    func responseData() -> AnyPublisher<Data, HTTPError> {
        tryMap { (data: Data, response: HTTPURLResponse) -> Data in
            switch response.statusCode {
            case 200...299: return data
            case 400...499: throw HTTPError.requestFailed(response.statusCode)
            case 500...599: throw HTTPError.serverError(response.statusCode)
            default:
                throw HTTPError.unhandlingResponse("Unhandled HTTP response ststus code: \(response.statusCode)")
            }
        }
        .mapError { error in
            if let httpError = error as? HTTPError {
                return httpError
            } else {
                return HTTPError.networkError(error)
            }
        }
        .eraseToAnyPublisher()
    }
}


enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}
