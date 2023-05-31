//
//  ContentView.swift
//  EPISDKExample
//
//  Created by Krzysztof Rodak on 29/05/2023.
//

import Combine
import SwiftUI
import EPINetworking

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel

    var body: some View {
        VStack {
            Text("Wallet fetch state")
                .padding()
            Text(viewModel.displayedStatus)
                .padding()
        }
        .padding()
        .onAppear {
            viewModel.loadWallet()
        }
    }
}

extension ContentView {
    final class ViewModel: ObservableObject {
        private let cancelBag = CancelBag()
        private let container: DIContainer
        @Published var walletRequest: Loadable<Wallet> = .notRequested
        @Published var displayedStatus: String = ""

        init(container: DIContainer) {
            self.container = container
            subscribeToWalletUpdates()
        }

        func loadWallet() {
            container.services.walletService.fetchWallet(
                walletId: "walletId",
                response: loadableSubject(\.walletRequest)
            )
        }

        func fetchWalletWithCombine() {
            container.repositories.walletRepository.fetchWallet(
                walletId: "walletId"
            ).sink { completion in
                switch completion {
                case .finished:
                    () // Request finished
                case let .failure(networkError):
                    self.displayedStatus = "There was an issue with wallet loading: \(networkError.message)"
                }
            } receiveValue: { wallet in
                self.displayedStatus = "Wallet successfully loaded: \(wallet.walletName)"
            }
            .store(in: cancelBag)
        }

        private func subscribeToWalletUpdates() {
            $walletRequest.sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                case .notRequested:
                    self.displayedStatus = "Wallet request not started"
                case .isLoading:
                    self.displayedStatus = "Wallet is loading..."
                case let .loaded(wallet):
                    self.displayedStatus = "Wallet successfully loaded: \(wallet.walletName)"
                case let .failed(networkError):
                    self.displayedStatus = "There was an issue with wallet loading: \(networkError.message)"
                @unknown default:
                    fatalError("Unexpected state for wallet request")
                }
            }
            .store(in: cancelBag)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: .init(container: .init()))
    }
}
