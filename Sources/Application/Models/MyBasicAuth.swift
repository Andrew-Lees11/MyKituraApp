import Credentials
import CredentialsHTTP
import LoggerAPI

public struct MyBasicAuth: TypeSafeHTTPBasic {
    public static let authenticate = ["username" : "password"]
    public static func verifyPassword(username: String, password: String, callback: @escaping (MyBasicAuth?) -> Void) {
        if let storedPassword = authenticate[username], storedPassword == password {
            return callback(MyBasicAuth(id: username))
        }
        callback(nil)
    }
    
    public var id: String
    
    
}
