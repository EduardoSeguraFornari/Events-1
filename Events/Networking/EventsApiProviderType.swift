import Foundation

protocol EventsApiProviderType {
    func request<T: Decodable>(for endpoint: EventsApi,
                               completion: @escaping (Result<T, AnyError>) -> Void)
    func request(for endpoint: EventsApiPost,
                 completion: @escaping (Result<Void, AnyError>) -> Void)
}
