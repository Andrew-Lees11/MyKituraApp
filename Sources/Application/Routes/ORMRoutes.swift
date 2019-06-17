//import KituraContracts
//import SwiftKueryORM
//import SwiftKueryPostgreSQL
//
//extension Book: Model { }
//func initializeORMRoutes(app: App) {
//    let pool = PostgreSQLConnection.createPool(host: "localhost", port: 5432, options: [.databaseName("bookdb")], poolOptions: ConnectionPoolOptions(initialCapacity: 10, maxCapacity: 50))
//    Database.default = Database(pool)
//    do {
//        try Book.createTableSync()
//    } catch {
//        print("Failed to create table: \(error)")
//    }
//    app.router.post("/orm", handler: app.saveHandler)
//    app.router.get("/orm", handler: app.findAllHandler)
//    app.router.get("/orm", handler: app.findOneHandler)
//}
//extension App {
//    func saveHandler(book: Book, completion: @escaping (Book?, RequestError?) -> Void) {
//        book.save(completion)
//    }
//    
//    func findAllHandler(completion: @escaping ([Book]?, RequestError?) -> Void) {
//        Book.findAll(completion)
//    }
//    
//    func findOneHandler(id: Int, completion: @escaping (Book?, RequestError?) -> Void) {
//        Book.find(id: id, completion)
//    }
//}
//
