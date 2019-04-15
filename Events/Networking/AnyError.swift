import Foundation

struct AnyError: Swift.Error {
    let error: Swift.Error
    
    init(_ error: Swift.Error) {
        if let anyError = error as? AnyError {
            self = anyError
        } else {
            self.error = error
        }
    }
}

extension AnyError: LocalizedError {
    var localizedDescription: String {
        return (error as? LocalizedError)?.localizedDescription ?? error.localizedDescription 
    }
}
