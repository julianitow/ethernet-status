//
//  ethernet_statusApp.swift
//  ethernet-status
//
//  Created by Julien Guillan on 22/06/2023.
//

import SwiftUI
import Network

@main
struct ethernet_statusApp: App {
    
    let monitorQueue = DispatchQueue.global(qos: .background)
    let monitor = NWPathMonitor()
    
    @AppStorage("ethernet") private var ethernet: Bool = false
    
    init() {
        monitorConnectivity()
    }
    
    func monitorConnectivity() {
        monitor.pathUpdateHandler = { path in
            if path.usesInterfaceType(.wiredEthernet) {
                self.ethernet = true
            } else {
                self.ethernet = false
            }
        }
        monitor.start(queue: monitorQueue)
    }
    
    var body: some Scene {
        MenuBarExtra("Ethernet status", systemImage: "point.3.filled.connected.trianglepath.dotted", isInserted: $ethernet) {
            Button("Quit")
            {
                NSApplication.shared.terminate(nil)
            }
        }
    }
}
