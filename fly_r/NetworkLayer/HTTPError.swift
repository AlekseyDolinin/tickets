import Foundation

enum HTTPError: Error {
    case nonHTTPResponse
    case serverError(Int)
    case requestFailed(Int)
    case networkError(Error)
    case decodingError(DecodingError)
    case unhandlingResponse(String)
}
