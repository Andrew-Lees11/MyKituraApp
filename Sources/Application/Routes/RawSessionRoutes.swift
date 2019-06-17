import KituraSession

func initializeRawSessionRoutes(app: App) {
    let session = Session(secret: "password", cookie: [CookieParameter.name("Raw-cookie")])
    app.router.all(middleware: session)
    
    app.router.get("/rawsession") { request, response, next in
        guard let session = request.session else {
            return try response.status(.internalServerError).end()
        }
        let books: [Book] = session["books"] ?? []
        response.send(books)
        next()
    }
    app.router.post("/rawsession") { request, response, next in
        guard let session = request.session else {
            return try response.status(.internalServerError).end()
        }
        let inputBook = try request.read(as: Book.self)
        var books: [Book] = session["books"] ?? []
        books.append(inputBook)
        session["books"] = books
        response.status(.created)
        response.send(inputBook)
        next()
    }
}
