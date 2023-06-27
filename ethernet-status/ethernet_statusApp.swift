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
    
    let monitorQueue = DispatchQueue.global(qos: .utility)
    let monitor = NWPathMonitor()
    
    @AppStorage("ethernet") private var ethernet: Bool = false
    
    init() {
        monitorConnectivity()
    }
    
    func monitorConnectivity() {
        monitor.pathUpdateHandler = { path in
            if path.usesInterfaceType(.wifi) {
                self.ethernet = false
            } else {
                self.ethernet = true
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
