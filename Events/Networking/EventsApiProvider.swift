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
    
    func request(for endpoint: EventsApiPost,
                 completion: @escaping (Result<Void, AnyError>) -> Void) {
        guard let url = endpoint.makeUrl() else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: endpoint.body) else {
            return
        }
        
        request.httpBody = httpBody
        
        session.dataTask(with: request) { (data, _, error) in
            guard let data = data else {
                completion(.failure(AnyError(error!)))
                return
            }
            
            print(String(data: data, encoding: .utf8))
            completion(.success(()))
        }
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
