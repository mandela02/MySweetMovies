//
//  InternetManager.swift
//  TemplateForSwiftUI
//
//  Created by Tri Bui Q. VN.Hanoi on 07/12/2022.
//

import Foundation
import Network

class InternetManager: ObservableObject {
    private lazy var monitor = NWPathMonitor()

    @Published
    var isConnectedToInternet = true
    
    init() {
        monitor.pathUpdateHandler = { [weak self] path in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if path.status == .satisfied {
                    self.isConnectedToInternet = true
                } else {
                    self.isConnectedToInternet = false
                }
            }
        }
        
        let queue = DispatchQueue(label: "Monitor")
        monitor.start(queue: queue)
    }
}
