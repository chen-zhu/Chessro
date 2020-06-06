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
        //hide current Chessboard IFF:
        //1. current device name is on the viewers list
        //2. joined peer name is on the hosts list
        
        let currentDeviceName = UIDevice.current.name.replacingOccurrences( of:"[^0-9a-zA-Z]", with: "", options: .regularExpression)
        let peerDeviceName = peer.displayName.replacingOccurrences( of:"[^0-9a-zA-Z]", with: "", options: .regularExpression)
        
        print("Peer Name: " + peerDeviceName + ". Current Name: " + currentDeviceName)
        
        if(viewers.contains(currentDeviceName) && hosts.contains(peerDeviceName)){
            //arView.scene.removeAnchor(ChessSceneAnchor)
            ChessSceneAnchor.synchronization = nil
            for child  in ChessSceneAnchor.children {
                child.isEnabled = false
            }
            print("Remove anchor from current device because peer is host and current device is viewer")
        }
    }
    
}
