# ConfigureID-iOS-SDK

[![License][license-image]][license-url]
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

Run the cocoapods linter.
```
pod lib lint
```

Push to cocoapods.
```
pod trunk push
```

[Here](https://github.com/CocoaPods/Specs/tree/master/Specs/a/b/6/ConfigureId) is the link to the updated podspect.

## Visualizer

TODO


## 🏷 License

`ConfigureID-iOS-SDK` is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.

[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
