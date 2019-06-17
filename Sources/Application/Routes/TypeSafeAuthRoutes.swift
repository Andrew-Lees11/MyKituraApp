import KituraContracts
import Credentials
import CredentialsHTTP
import LoggerAPI

func initializeTypeSafeAuthRoutes(app: App) {
    app.router.get("/basic", handler: app.protectedGetHandler)
}
extension App {
    func protectedGetHandler(user: MyBasicAuth, respondWith: (Book?, RequestError?) -> Void) {
        Log.info("authenticated: \(user.id)")
        let secretBook = Book(id: 451, title: "1984", price: 9001, genre: "Science Fiction")
        respondWith(secretBook, nil)
    }
}
