// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "MyKituraApp",
    dependencies: [
        .package(url: "https://github.com/IBM-Swift/Kitura.git", from: "2.6.0"),
        .package(url: "https://github.com/IBM-Swift/HeliumLogger.git", from: "1.7.1"),
        .package(url: "https://github.com/IBM-Swift/Kitura-OpenAPI.git", from: "1.0.0"),
//        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-ORM.git", from: "0.4.0"),
//        .package(url: "https://github.com/IBM-Swift/Swift-Kuery-PostgreSQL.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CouchDB.git", from: "3.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-Session.git", from: "3.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-Credentials.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CredentialsHTTP.git", from: "2.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-StencilTemplateEngine.git", from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/FileKit.git", from: "0.0.1"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CredentialsFacebook.git", from: "2.3.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-CredentialsGoogle.git", from: "2.3.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-Markdown.git", from: "1.0.0"),
        .package(url: "https://github.com/IBM-Swift/Kitura-net.git", .branch("2.3.0+debugging+client")),
        ],
    targets: [
        .target(name: "MyKituraApp", dependencies: [ .target(name: "Application"), "Kitura" , "HeliumLogger"]),
        .target(name: "Application", dependencies: [ "Kitura", "KituraOpenAPI", "CouchDB", "KituraSession", "CredentialsHTTP", "KituraStencil", "FileKit", "Credentials", "CredentialsFacebook", "CredentialsGoogle", "KituraMarkdown"]),
        
        .testTarget(name: "ApplicationTests" , dependencies: [.target(name: "Application"), "Kitura","HeliumLogger" ])
    ]
)
