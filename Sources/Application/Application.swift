import Kitura
import LoggerAPI
import Dispatch
import KituraOpenAPI
import FileKit

public class App {
    let workerQueue = DispatchQueue(label: "worker")
    let router = Router()
//    #if os(Linux)
//    let mySSLConfig =  SSLConfig(withCACertificateDirectory: nil, 
//                                 usingCertificateFile: FileKit.projectFolder + "/Credentials/cert.pem", 
//                                 withKeyFile: FileKit.projectFolder + "/Credentials/key.pem", 
//                                 usingSelfSignedCerts: true)
//    #else // on macOS
//    
//    let mySSLConfig =  SSLConfig(withChainFilePath: FileKit.projectFolder + "/Credentials/cert.pfx",
//                                 withPassword: "password",
//                                 usingSelfSignedCerts: true)
//    
//    #endif

    
    public init() throws {
        Log.info(FileKit.projectFolder)
    }
    
    func postInit() throws {
        router.all("/public", middleware: StaticFileServer(path: "./public"))
        initializeCodableRoutes(app: self)
        KituraOpenAPI.addEndpoints(to: router)
//        initializeORMRoutes(app: self)
        initializeRawRoutes(app: self)
        initializeCouchRoutes(app: self)
        initializeTypeSafeSessionRoutes(app: self)
        initializeTypeSafeAuthRoutes(app: self)
        initializeStencilRoutes(app: self)
        initializeOAuth2Routes(app: self)
        initializeRawSessionRoutes(app: self)
    }
    
    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }
    
    func execute(_ block: (() -> Void)) {
        workerQueue.sync {
            block()
        }
    }
}
enum TopicSelectionType: String, Codable {
    case none = "none"
    case have = "have"
    case need = "need"
    
    static let notSelectedIndex = -1
}

final class Topic: Hashable, Comparable, Codable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
        hasher.combine(category)
    }
    
    static func == (lhs: Topic, rhs: Topic) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    static func < (lhs: Topic, rhs: Topic) -> Bool {
        return lhs.category + lhs.name < rhs.category + rhs.name
    }
    
    let id: Int?
    let name: String
    let category: String
    var selectedListIndex = TopicSelectionType.notSelectedIndex
    var selectionType: TopicSelectionType = .none
    
    init() {
        self.name = ""
        self.category = ""
        self.id = 0
    }
    
    init(name: String, category: String) {
        self.name = name
        self.category = category
        self.id = 0
    }
    
    func hasText(_ searchTerm: String) -> Bool {
        return category.lowercased().contains(searchTerm.lowercased()) || name.lowercased().contains(searchTerm.lowercased())
    }
}

extension TopicSelectionType {
    static func validCodingValue() -> Any? {
        return self.none.rawValue
    }
    
    
}
