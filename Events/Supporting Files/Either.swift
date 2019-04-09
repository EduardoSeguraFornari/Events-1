import Foundation

enum Either<Left, Right> {
    case left(Left)
    case right(Right)
}

extension Either {
    var left: Left? {
        guard case let .left(value) = self else { return nil }
        return value
    }
    
    var right: Right? {
        guard case let .right(value) = self else { return nil }
        return value
    }
}

extension Either: Decodable where Left: Decodable, Right: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        
        if let lhs = try? container.decode(Left.self) {
            self = .left(lhs)
            return
        }
        
        if let rhs = try? container.decode(Right.self) {
            self = .right(rhs)
            return
        }
        
        throw DecodingError.typeMismatch(Either.self,
                                         DecodingError.Context(codingPath: decoder.codingPath,
                                                               debugDescription: "Wrong type for Either"))
        
    }
}
