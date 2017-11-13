SwiftCodeWriter
=================================

[![Swift Version](https://img.shields.io/badge/swift-4.0-orange.svg?style=flat)](https://developer.apple.com/swift/)
[![Swift Package Manager](https://rawgit.com/jlyonsmith/artwork/master/SwiftPackageManager/swiftpackagemanager-compatible.svg)](https://swift.org/package-manager/)
[![Twitter](https://img.shields.io/badge/twitter-@Digipolitan-blue.svg?style=flat)](http://twitter.com/Digipolitan)

Library to write swift source code

## Installation

### SPM

To install SwiftCodeWriter with SwiftPackageManager, add the following lines to your `Package.swift`.

```swift
let package = Package(
    name: "XXX",
    products: [
        .library(
            name: "XXX",
            targets: ["XXX"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Digipolitan/swift-code-writer.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "XXX",
            dependencies: ["SwiftCodeWriter"])
    ]
)
```

## The Basics

The you must create a file description that represent the swift output file

```swift
let fileDescription = FileDescription()
```

A file description can contains :
- classes `[ClassDescription]`
- enums `[EnumDescription]`
- protocols `[ProtocolDescription]`
- extensions `[ExtensionDescription]`
- methods `[MethodDescription]`
- properties `[PropertyDescription]`
- documentation

The following example will show how to register a structure inside the file description

```swift
// Add a User struct with 2 properties
var cd = ClassDescription(name: "User", options: .init(visibility: .public, isReferenceType: true))
cd.properties.append(.init(name: "lastName", type: "String?"))
cd.properties.append(.init(name: "firstName", type: "String?"))
fileDescription.classes.append(cd)
```

After that use the FileWriter to transform the given FileDescription to string as follow

```swift
let res = FileWriter.default.write(description: fileDescription)
```

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for more details!

This project adheres to the [Contributor Covenant Code of Conduct](CODE_OF_CONDUCT.md).
By participating, you are expected to uphold this code. Please report
unacceptable behavior to [contact@digipolitan.com](mailto:contact@digipolitan.com).

## License

SwiftCodeWriter is licensed under the [BSD 3-Clause license](LICENSE).
