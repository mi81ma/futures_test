import Vapor

// Customerのstructをつくる
struct Customer :Content {
    var name :String
}

/// Register your application's routes here.
public func routes(_ router: Router) throws {

    // route "hello"に来たリクエストは、Future.mapで、
    // request と return "Hello World"を結びつけている
    router.get("hello") { request -> Future<String> in
        return Future.map(on: request, { () -> String in
            return "Hello World"
        })
    }

    // route "customers"に来たリクエストは、Future<[Customer]>で
    // getAllCustomers()を返す
    router.get("customers") { request -> Future<[Customer]> in

        return getAllCustomers(req: request)
    }

    // getAllCustomers()をつくる
    func getAllCustomers(req :Request) -> Future<[Customer]> {

        return Future.flatMap(on: req) { () -> EventLoopFuture<[Customer]> in

            var customers = [Customer(name: "john"), Customer(name: "mary")]
            customers[0].name = "Alex"

            return Future.map(on: req, { () -> [Customer] in
                return customers
            })
        }
    }
}
