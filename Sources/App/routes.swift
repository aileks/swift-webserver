import Fluent
import Vapor

func routes(_ app: Application) throws {
  app.get { req async throws in
    try await req.view.render("index", ["title": "Hello Vapor!"])
  }

  app.get("hello", ":name") { req async throws -> String in
    let name = try req.parameters.require("name")
    return "Hello, \(name.capitalized)!"
  }

  app.get("json", ":name") { req async throws -> UserResponse in
    let name = try req.parameters.require("name")
    let message = "Hello, \(name.capitalized)!"
    return UserResponse(message: message)
  }

  app.post("user-info") { req async throws -> UserResponse in
    let userInfo = try req.content.decode(UserInfo.self)
    let message = "Hello, \(userInfo.name) you are \(userInfo.age) years old!"
    return UserResponse(message: message)
  }

  try app.register(collection: TodoController())
}

struct UserResponse: Content {
  let message: String
}

struct UserInfo: Content {
  let name: String
  let age: Int
}
