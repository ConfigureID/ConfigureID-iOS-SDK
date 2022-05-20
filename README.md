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
            name: "ConfigureID-iOS-SDK",
            url: "https://github.com/FranDepascuali/ConfigureID-iOS-SDK",
            .exact("0.0.1")
        ),
    ],
    //...
)
```

## Authentication
You need to authenticate with your apiKey to use this SDK.
```swift
import ConfigureID_iOS_SDK

ConfigureID.setApiKey(apiKey: "YOUR_API_KEY")
```

## Usage example


```swift
import ConfigureID_iOS_SDK

ConfigureID.setApiKey(apiKey: "YOUR_API_KEY")
ConfigureID
    .Customers
    .fetchProducts(
        customerId: "CUSTOMER_ID",
        onSuccess: { (products: [ProductSummary]) in
            print(products)
        },
        onError: { (error: ConfigureIDError) in
            print(error)
        }
    )
```

## Endpoints

Name of the methods are displayed below. Each method receives different parameters, you'll need to fill the `(...)`.

### Customers

```swift
// Retrieves all products of a customer.
ConfigureID.Customers.fetchProducts(...)

// Retrieves the data of a product.
ConfigureID.Customers.fetchProductData(...)
```

### Sessions 
```swift
// Retrieves the current state of the session. 
ConfigureID.Sessions.fetchSession(...)

// Resets a session.
ConfigureID.Sessions.resetSession(...)

// Creates a new session.
ConfigureID.Sessions.createSession(...)

// Updates a recipe.
ConfigureID.Sessions.updateRecipe(...)
```

### Recipes
```swift
// Retrieves an existing recipe.
ConfigureID.Recipes.fetchRecipe(...)

// Creates a new recipe. 
ConfigureID.Recipes.createRecipe(...)
```

## Contributing

### Install Swiftlint
```
brew install swiftlint
```

## Visualizer

TODO


## 🏷 License

`ConfigureID-iOS-SDK` is available under the MIT license. See the [LICENSE file](./LICENSE) for more info.

[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE