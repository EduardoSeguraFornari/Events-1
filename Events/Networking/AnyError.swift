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
