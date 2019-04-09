import Foundation

struct User {
    let name: String
    let email: String
}

extension User {
    func asDictionary() -> [String: Any] {
        var dict: [String: Any] = [:]
        
        dict["name"] = name
        dict["email"] = email
        
        return dict
    }
}
