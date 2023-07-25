//
//  NetworkMonitor.swift
//  CinemaTracker
//
//  Created by Yunus Çağlıyan on 25.07.2023.
//

import Foundation
import Network
import SPIndicator
import UIKit

final class NetworkMonitor {
    static let shared = NetworkMonitor()
    
    private let queue = DispatchQueue.global()
    private let monitor: NWPathMonitor
    
    public private(set) var isConnected: Bool = false
    
    var listener: ((Bool) -> Void)? = nil
    
    private init() {
        monitor = NWPathMonitor()
    }
    
    
    public func startMonitoring() {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            let connection = path.status == .satisfied
            self?.isConnected = connection
            self?.listener?(connection)
            if connection {
                print("Connected")
            } else {
                print("Disconnected")
                self?.showErrorMessage()
            }
        }
    }
    
    public func stopMonitoring() {
        monitor.cancel()
    }
    
    private func showErrorMessage() {
        DispatchQueue.main.async {
            let image = UIImage(systemName: "wifi.slash")?.withTintColor(AppTheme.shared.colors.secondary, renderingMode: .alwaysOriginal)
            if let image = image {
                SPIndicator.present(title: LocalizableKeys.Common.noConnection.getLocalized(), preset: .custom(image))
            }
        }
    }
}
