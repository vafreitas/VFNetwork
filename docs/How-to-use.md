
Basically, you need two files to assemble your requests and put Base_URL, Protocol and Environment in your info.plist.

### Info.plist 

![Yout Plist](https://github.com/vafreitas/VFNetwork/blob/master/Assets/Examples/info-plist.png)

You have 3 types of Environments for you choose.

```swift
enum EnvironmentCase: String {
    case production = "production"
    case sandbox = "sandbox"
    case mock = "mock"
}
```

In sandbox and mock you will see logs of the VFNetwork itself.


### HomeAPI.swift

Here you will configure your requests.

```swift

import VFNetwork

enum HomeAPI {
    case joke
    case categories
}

extension HomeAPI: APIBuilder {
    
    var path: URLPath {
        switch self {
        case .joke:
            return .plain("jokes/random")
        case .categories:
            return .plain("jokes/categories")
        }
    }
    
    var httpMethod: HTTPMethods {
        switch self {
        case .joke, .categories:
            return .get
        }
    }
    
    var headers: HTTPHeader {
        .custom([
            .bearer("yourToken"),
            .basic("yourBase64"),
            .header("custom", "header")
        ])
    }
    
    var task: HTTPTask {
        switch self {
        case .joke, .categories:
            return .request
        }
    }
    
```

### HomeService.swift

And here you will execute your requests.

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

