# EPI SDK
--------

[![Swift Version](https://img.shields.io/badge/Swift-5.5-orange.svg)](https://swift.org)
[![SPM Compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://swift.org/package-manager)
![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)
![iOS Version](https://img.shields.io/badge/iOS-15.0%2B-blue.svg)
![Test Coverage](https://img.shields.io/badge/Test%20Coverage-86%25-green.svg)
![Documentation Coverage](https://img.shields.io/badge/Documentation%20Coverage-100%25-brightgreenų.svg)


EPISDK is a Swift package that provides easy access to set of features for European Payment Initiative platform for iOS app development.

## Features
--------

### EPI Networking module

- Provides access methods for avaialble EPI API services with two sets of interfaces:
  - Combine handlers through `AnyPublisher` for each resource
  - SwiftUI focused handlers that provide `Binding` based wrappers that are easily integrated with `@Published` variables in ViewModels

## Requirements
------------

- iOS 15.0+
- Xcode 14.0+
- Swift 5.5+

## Installation
------------

EPISDK can be easily integrated into your project using the Swift Package Manager (SPM). Simply add it as a dependency in your `Package.swift` file:

```swift
dependencies: [
    .package(url: "https://github.com/epicompany/episdkios.git", from: "0.1.0")
]
```

## Example Application

To see EPI SDK in action, check out the [Example Application](./Examples/). that demonstrates how to integrate and utilize the SDK in a sample iOS app.

## Documentation

Comprehensive documentation for EPISDK is available [here](https://epicompany.github.io/docs/mobile/sdk/ios/EPINetworking/index.html). It provides detailed information on how to use EPI SDK, including API references and usage examples.
