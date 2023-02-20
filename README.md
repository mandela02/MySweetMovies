# MySweetMovies
`MySweetMovie` is everything you need about movies. 

## How to run
open `MySweetMovie.xcworkspace` and wait all the package request to finish.

## Architecture
`MySweetMovie` is following the `MVVM - Clean Architecture` . It can be divided into three parts. 

### Platform
- this is where `MySweetMovie` communicate with the backend server [TheMovieDB](https://developers.themoviedb.org/3/getting-started/introduction). It contains all the api call methods and error handles. 
- Every api call methods are in a generic class called `ApiRepository<T: Codable>` , it's a part of my [CoreApiConcurrency](https://github.com/mandela02/CoreApiConcurrency) package. `MySweetMovie` will inheritance this class, create multiple `Repository` using its own objects. 
- [TheMovieDB](https://developers.themoviedb.org/3/getting-started/introduction) is very clear about the error object, so every api request have the same response pattern. It can be found in the `BaseEntity.swift` file.
- `Repository` s are provided to Domain using a `RepositoryProvider`.
- Api response will be put into `Entity`
- `Repository` are using **_Async await_**. Every time api return a error object, throw an `NSError`

### Domain

- This is where `MySweetMovie` transform api response into data that will be use in the app. 
- `MySweetMovie` will request data it need via `UseCase`
- Each `UseCase` only handle one function, it need to inheritance the `UseCaseProtocol`

```
public protocol InputOutputUseCaseProtocol {

associatedtype Output
associatedtype Input

func run(input: Input) async throws -> Output

}
```

- `Domain` receive `Entity` from `Platform`, map into its own model, and `Model`
- Separate `Entity` and `Model` is necessary, because, in case of a api update, Devs will only need to change `Entity` and the mapping function, everything else is safe and untouched.

### App - Presentation. 

- This is the front end, it's follow the MVVM design pattern. 
- Each screen will be separated into 3 part
- ***Navigator*** will handle all the change screen logics. Every `push`, `present` request will be put in here. This will clear out the navigation tree and the app flows for further expansion or maintenance
- ***ViewModel***  is the brain of a screen. It's contain the `Navigator`, all the `UseCase` and a special struct call `State`. ***ViewModel*** need to inheritance `BaseViewModel<State>` .
- `State` is everything show on the screen, change the `State` will automatically update the screen. 
- ***ViewModel*** will has multiple `UseCase` , each action will have its own `UseCase`. After `await useCase.run(input:)`, update `State` base on `UseCase's Output`
- ***View*** are using `SwiftUI`, populate by ***viewModel***'s  `State`

### Extra Information. 
- TLDD: `Platform` talk to server, `Presentation` talk to `Platform` via `Domain`. 
- `MySweetMovie` is the love child of `UIKit` and `SwiftUI`. It has the structure of a `UIKit` app, but all the view is `SwiftUI`
-  The reason behind this choice of tech is `SwiftUI's Navigation` can be messy and hard to track. There for, the born of ***Navigator***.

## Library
### TriBQ's Library
-  Api Wrapper: [CoreApiConcurrency](https://github.com/mandela02/CoreApiConcurrency)
- For using UIKit view in SwiftUI view (UITableView, UICollectionView, etc...): [UnderlyingViewForSwiftUI](https://github.com/mandela02/UnderlyingViewForSwiftUI)
- SwiftUI Extension: [SwiftUIExtension](https://github.com/mandela02/SwiftUIExtension)
- Utilities function for Swift Language: [SwiftUtilities](https://github.com/mandela02/SwiftUtilities)

### 3rd Party
-  `CoreApiConcurrency` using some of [Alamofire](https://github.com/Alamofire/Alamofire)
- For Network Image: [Nuke](https://github.com/kean/Nuke)
