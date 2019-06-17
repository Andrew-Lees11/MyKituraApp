import KituraStencil
import KituraMarkdown

func initializeStencilRoutes(app: App) {
    app.router.add(templateEngine: StencilTemplateEngine())
    app.router.add(templateEngine: KituraMarkdown())
    app.router.get("/stencil") { request, response, next in
        let book = Book(id: 0, title: "A Game of Thrones", price: 14.99, genre: "fantasy")
        try response.render("book.stencil", with: book)
        next()
    }
    app.router.get("/book") { request, response, next in
        try response.render("book.md", context: [:])
    }
}
