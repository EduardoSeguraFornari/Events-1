enum Result<Success, Failure: Error> {
    case success(Success)
    case failure(Failure)
}

extension Result: Equatable where Success: Equatable, Failure: Equatable { }

extension Result: Hashable where Success: Hashable, Failure: Hashable { }
