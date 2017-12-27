import KeychainAccess

struct TokenService {
    
    static let defaults = UserDefaults.standard
    static let keychain = Keychain(service: "com.kfrancois.Eatr-token")
    
    static func save(token: String, for username: String) {
        keychain[username] = token
        defaults.set(username, forKey: "username")
    }
    
    static var token: String? {
        get {
            if(username == nil) {
                // do something
                return ""
            } else {
                return keychain[username!]
            }
        }
    }
    
    static var username: String? {
        get {
            return defaults.string(forKey: "username")
        }
    }
}
