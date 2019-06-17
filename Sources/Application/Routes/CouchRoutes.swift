import KituraContracts
import CouchDB
import LoggerAPI

func initializeCouchRoutes(app: App) {
    app.router.post("/couch", handler: app.couchSaveHandler)
    app.router.get("/couch", handler: app.couchFindAllHandler)
}
extension App {
    static let properties = ConnectionProperties(
        host: "127.0.0.1",              // http address
        port: 5984,                     // http port
        secured: false,                 // https or http
        username: nil, // admin username
        password: nil  // admin password
    )
    static let couchDBClient = CouchDBClient(connectionProperties: properties)
    func couchSaveHandler(book: BookDocument, completion: @escaping (BookDocument?, RequestError?) -> Void) {
        App.couchDBClient.retrieveDB("bookstore") { (database, error) in
            guard let database = database  else {
                return completion(nil, .internalServerError)
            }
            database.create(book) { (response, error) in
                guard let response = response else {
                    return completion(nil, RequestError(httpCode: error?.statusCode ?? 500))
                }
                var updatedBook = book
                updatedBook._id = response.id
                updatedBook._rev = response.rev
                completion(updatedBook, nil)
            }
        }
    }
    
    func couchFindAllHandler(completion: @escaping ([BookDocument]?, RequestError?) -> Void) {
        App.couchDBClient.retrieveDB("bookstore") { (database, error) in
            guard let database = database  else {
                return completion(nil, .internalServerError)
            }
            database.retrieveAll(includeDocuments: true, callback: { (allDocuments, error) in
                guard let allDocuments = allDocuments else {
                    return completion(nil, RequestError(httpCode: error?.statusCode ?? 500))
                }
                let books = allDocuments.decodeDocuments(ofType: BookDocument.self)
                completion(books, nil)
            })
        }
    }
}
