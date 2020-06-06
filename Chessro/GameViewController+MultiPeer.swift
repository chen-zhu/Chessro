//
//  GameViewController+MultiPeer.swift
//  Chessro
//
//  Created by Stone Zhu on 6/6/20.
//  Copyright © 2020 Stone Zhu. All rights reserved.
//


import UIKit
import RealityKit
import ARKit
import MultipeerConnectivity

extension GameViewController: MultipeerHelperDelegate {
    
    func setupMultipeer() {
        multipeerHelp = MultipeerHelper(
            serviceName: "helper-test",
            sessionType: .both,
            delegate: self
        )
        
        guard let syncService = multipeerHelp.syncService else {
            print("Unable to turn on RealityKit Sync.")
            return
        }
        arView.scene.synchronizationService = syncService
    }
    
    func receivedData(_ data: Data, _ peer: MCPeerID) {
        print(String(data: data, encoding: .unicode) ?? "DATA CORRUPTED")
    }
    
    func peerJoined(_ peer: MCPeerID) {
        print("NEW PEER JOINED: \(peer.displayName)")
    }
    
}
