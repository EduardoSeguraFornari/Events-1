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
        
        session.dataTask(with: request) { (_, _, error) in
            guard error == nil else {
                DispatchQueue.main.async {
                    completion(.failure(AnyError(error!)))
                }
                return
            }
            DispatchQueue.main.async {
                completion(.success(()))
            }
        }.resume()
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
                DispatchQueue.main.async {
                    completion(.success(model))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(AnyError(error)))
                }
            }
        }.resume()
    }
}
