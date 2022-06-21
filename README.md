# ConfigureID-iOS-SDK

<a href="https://github.com/apple/swift-package-manager">
  <img src="https://img.shields.io/badge/spm-compatible-brightgreen.svg?style=flat" />
</a>

This SDK exposes the endpoints necessary for interacting with Configure and viewing products.
You can take a look at the API at https://prod-ingress.fluidconfigure.com/headless/docs/.

## Installation

### Xcode Projects

Select `File` -> `Swift Packages` -> `Add Package Dependency` and enter `https://github.com/FranDepascuali/ConfigureID-iOS-SDK`.

### Swift Package Manager Projects

You can add `ConfigureID-iOS-SDK` as a package dependency in your `Package.swift` file:

```swift
let package = Package(
    //...
    dependencies: [
        .package(
            name: "ConfigureId",
            url: "https://github.com/FranDepascuali/ConfigureID-iOS-SDK",
            .exact("0.0.5")
        ),
    ],
    //...
)
```

```ruby
pod 'ConfigureId', '0.0.5'
```

### 

## Authentication
You need to authenticate with your apiKey to use this SDK.
```swift
import ConfigureId

ConfigureId.setApiKey(apiKey: "YOUR_API_KEY")
```

## Usage example

Ensure you already authenticated. Then you can use the SDK, i.e:

```swift
ConfigureId
    .Customers
    .fetchProducts(
        customerId: "CUSTOMER_ID",
        onSuccess: { (products: [ProductSummary]) in
            print(products)
        },
        onError: { (error: ConfigureIdError) in
            print(error)
        }
    )
```

## Endpoints

Name of the methods are displayed below. Each method receives different parameters, you'll need to fill the `(...)`.

### Customers

```swift
// Retrieves all products of a customer.
ConfigureId.Customers.fetchProducts(...)

// Retrieves the data of a product.
ConfigureId.Customers.fetchProductData(...)
```

### Sessions 
```swift
// Retrieves the current state of the session. 
ConfigureId.Sessions.fetchSession(...)

// Resets a session.
ConfigureId.Sessions.resetSession(...)

// Update session.
ConfigureId.Sessions.updateSession(...)

// Creates a new session.
ConfigureId.Sessions.createSession(...)

// Updates a recipe.
ConfigureId.Sessions.updateRecipe(...)
```

### Recipes
```swift
// Retrieves an existing recipe.
ConfigureId.Recipes.fetchRecipe(...)

// Creates a new recipe. 
ConfigureId.Recipes.createRecipe(...)
```

## Contributing

### Install Swiftlint
```
brew install swiftlint
```

### Publish cocoapods version

- Run the cocoapods linter.
    ```
    pod lib lint
    ```

- Publish a new git tag.

- Generate a github release.

- Push to cocoapods.
    ```
    pod trunk push
    ```

[Here](https://github.com/CocoaPods/Specs/tree/master/Specs/a/b/6/ConfigureId) is the link to the updated podspec.

### Tests

- Open the project, so run this on the root of the project
```
xed .
```

- First of all, locate the file `sample-config.json`

- You will need to complete the json with your information (i.e: apiKey, customerId, etc)...

- Beware that sessions expire every day, so you'd probably need to recreate them and replace on the json.

- Go to TestConfig+swiftPackage and change current() to load the json you created (take a look at the other configurations if you have doubts).

- There are transitive dependencies (i.e: session depends on customer and product, recipe depends on session) so you'll need to run the tests, adjust the configuration and eventually all tests will pass.
Tests run createSession and createRecipe, so you can use the ids returned by those queries (or perform the queries outside via terminal).

## Visualizer

Sample of 2D and 3D visualizer, with an update recipe use case implemented.

![demo_visualizer_3d](https://user-images.githubusercontent.com/12101394/173745047-e096264a-6ec7-4cea-8db9-651929b28b5f.gif)

- Be sure you could run the tests, because the configuration used is the same in the tests and the visualizer.
- Open the demo project
    ```
    xed ConfigureIdDemo
    ```
- The demo runs some query calls, included update recipe. To be able to run it, ask the team for the correct values.
- The demo will pick the data from the json config files. Make sure you create the `prod-2d-product.json` and `prod-3d-product.json`

## 🏷 License

`ConfigureID-iOS-SDK` is available under the GPL v3 license. See the [LICENSE file](./LICENSE) for more info.

[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
