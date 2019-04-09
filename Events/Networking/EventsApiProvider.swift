import Foundation

final class EventsApiProvider {
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(for endpoint: EventsApi,
                               completion: @escaping (Result<T, AnyError>) -> Void) {
        guard let url = endpoint.makeUrl() else { return }
        request(for: url, completion: completion)
    }
    
    private func request<T: Decodable>(for url: URL, completion: @escaping (Result<T, AnyError>) -> Void) {
        session.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(AnyError(error!)))
                return
            }
            
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .millisecondsSince1970
            do {
                let model = try jsonDecoder.decode(T.self, from: data)
                completion(.success(model))
            } catch {
                completion(.failure(AnyError(error)))
            }
        }.resume()
    }
}
