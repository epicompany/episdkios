//
//  DIContainer.swift
//  EPISDKExample
//
//  Created by Krzysztof Rodak on 30/05/2023.
//

import Foundation
import EPINetworking

/// Example implementation for `AccessTokenProviding` protocol
/// Bare in mind that its implementation should reflect any security measures that are part of access token handling
/// within project that integrates this SDK.
/// Having dedicated protocol with single method to provide access token aims to provide flexibility
/// on SDK implementor side, not forcing any approach on how access token is stored or handled in integrator application.
///
/// I.e. access token could be stored in Keychain and your Keychain mediator class could implement `AccessTokenProviding`
/// Or `AccessTokenProvider` could use that Keychain mediator as dependency.
final class AccessTokenProvider: AccessTokenProviding {
    private let myAccessToken = "accessToken"

    /// This method should provide always-up-to-date access token.
    /// - Returns: Always-up-to-date access token
    func provideAccessToken() -> String? {
        myAccessToken
    }
}


/// Example container for dependency injection within project
struct DIContainer {
    let accessTokenProvider: AccessTokenProviding
    let services: EPIServicesProtocol
    let repositories: EPIRepositoriesProtocol

    init() {
        // Instance of some object that will provide up to date access token
        let accessTokenProvider = AccessTokenProvider()
        let authenticationUpdate: (NetworkError) -> Void = { _ in
            // If needed, do special 401 unauthorised handling here, i.e. trigger refresh access token process
        }
        // Base URL to EPI provided API environment
        let baseUrl = "https://www.api.epicompany.eu"
        // Define level of log information in Xcode console needed
        let logLevel: EPINetworkingLogLevel = .off

        // Configuration wrapper object that combines above variables
        let configuration = EPINetworkingConfiguration(
            baseURL: baseUrl,
            logLevel: logLevel,
            accessTokenProvider: accessTokenProvider,
            authenticationUpdate: authenticationUpdate
        )
        // Initialise networking factory class that can build services or repositories to be used within your app
        let epiFactory = EPINetworkingFactory()
        // Set of services that provide convinient SwiftUI wrappers for API requests result
        // that's easy to be used in ViewModels
        let epiServices = epiFactory.buildServices(configuration)
        // Set of repositories that provide standard Combine interface for API requests
        // that might be more suitable in non-UI code, outside of ViewModels
        let epiRepositories = epiFactory.buildRepositories(configuration)

        self.accessTokenProvider = accessTokenProvider
        services = epiServices
        repositories = epiRepositories
    }
}
