# Builder

With APIBuilder you can configure your requests. For Example.

```Swift
enum HomeAPI {
    case home
    case categories(ExampleStruct)
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .home:
            return .plain("jokes/random")
        case .categories:
            return .plain("jokes/categories")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .home:
            return .get
        case .categories:
            return .post
        }
    }
    
    var headers: HTTPHeader {
        .bearer("Bearer yourToken")
    }
    
    var task: HTTPTask {
        switch self {
        case .home:
            return .request
        case let .categories(model):
            return .requestEncoder(model)
        }
    }
}
```

## Configuration Variables.

### URLPath

With URLPath you can configure two types of URLs.

```Swift
.plain("jokes/random") // jokes/random
.composed("joke", pathId: "ID") // /joke/10
```

### HTTPMethods

With HTTPMethods you can choose five types of methods.

```Swift
.get
.post
.put
.patch
.delete
```

### HTTPHeader

With HTTPHeader you can choose five types of headers.

```Swift
.custom([
  .header("key", "value"),
  .bearer("YourToken")
]) // Array of HTTPHeader

// Only one option
.bearer("yourToken")
.basic("yourBase64")
.header("key", "value")
```

### HTTPTask

With HTTPTask you can choose five types of tasks.

```Swift 
.request // Plain
.requestBody([
     "name": "Victor",
     "lastname": "Freitas"
]) // Body
.requestEncoder(model) // Body
.requestURLParameters(urlParameters: ["transactionId": "ID"]) // Query String
.requestParameters(bodyParameters: ["name": "Victor"], urlParameters: ["transactionId": "ID"]) // Body with Query String.
```

# Request Service

With RequestService you can execute your requests. For Example.


```swift 
import VFNetwork

class HomeService: RequestService<HomeAPI> {
    func getJoke(completion: @escaping (Result<JokeModel, Error>) -> Void) {
        execute(.joke, responseType: JokeModel.self, completion: completion)
    }
    
    func getCategories(completion: @escaping (Result<CategoryModel, Error>) -> Void) {
        execute(.categories, responseType: CategoryModel.self, completion: completion)
    }
}

```
