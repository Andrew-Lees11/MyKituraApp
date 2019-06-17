import Credentials
import CredentialsGoogle
import KituraSession

func initializeOAuth2Routes(app: App) {
    
    let session = Session(secret: "AuthSecret", cookie: [CookieParameter.name("Kitura-Auth-cookie")])
    app.router.all("/oauth2", middleware: session)
    
    let googleClientId = "255452365192-c968fkma00thm5buktd4n607qirp3bej.apps.googleusercontent.com"
    let googleClientSecret = "j5oJSoJ-m5T6baKzrRzFJIy1"
    let googleCallbackUrl = "http://localhost:8080/oauth2/google"
    let googleCredentials = CredentialsGoogle(clientId: googleClientId, clientSecret: googleClientSecret, callbackUrl: googleCallbackUrl)
    
    let googleCredMiddleware = Credentials(options: ["successRedirect": "/oauth2/protected"])
    googleCredMiddleware.register(plugin: googleCredentials)
    
    app.router.get("/oauth2/google", handler: googleCredMiddleware.authenticate(credentialsType: googleCredentials.name))
    
    app.router.get("/oauth2/protected") { request, response, next in
        guard let user = request.userProfile else {
            return try response.send("Not authorized to view this route").end()
        }
        response.send("Hello \(user.displayName)")
        next()
    }
    
    app.router.get("/oauth2/logout") { request, response, next in
        googleCredMiddleware.logOut(request: request)
        next()
    }
}
