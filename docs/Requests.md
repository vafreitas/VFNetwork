
🏠 <a href="/VFNetwork/">Home</a> -> 
📗 <a href="/VFNetwork/Requests">Requests</a>

# GET

To configure a route with the get method just configure your httpMethod with **.get** and task with **.request**.

```Swift 
enum HomeAPI {
    case home
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .home:
            return .plain("jokes/random")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .home:
            return .get // Define method GET
        }
    }
    
    var headers: HTTPHeader {
        .empty
    }
    
    var task: HTTPTask {
        switch self {
        case .home:
            return .request // This performs a request without a body
        }
    }
}
```

# POST, PUT, PATCH and DELETE.

To configure a route with the post, put, patch or delete method just configure your httpMethod with **.post, .put, .patch, .delete** and task with **.requestEncoder** with protocol **VCodable** or other type of task.

For your request you can choose different tasks, For example.

### Type of Tasks.

```Swift 
.requestBody([
     "name": "Victor",
     "lastname": "Freitas"
]) // Body

.requestEncoder(model) // Body
.requestURLParameters(urlParameters: ["transactionId": "ID"]) // Query String
.requestParameters(bodyParameters: ["name": "Victor"], urlParameters: ["transactionId": "ID"]) // Body with Query String.
```

### VCodable Model Example.

```Swift
struct ExampleModel: VCodable {
    var name: String
    var lastname: String
}
```

### POST Example
You can do that for PUT, PATCH and DELETE, just choose correct httpMethod and configure your task :).

```Swift
enum HomeAPI {
    case home(ExampleModel)
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .home:
            return .plain("jokes/random")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .home:
            return .post // Define method POST
        }
    }
    
    var headers: HTTPHeader {
        .bearer("yourToken")
    }
    
    var task: HTTPTask {
        switch self {
        case let .home(model):
            return .requestEncoder(model) // This performs a request with a body conforms protocol VCodable.
        }
    }
}
```
