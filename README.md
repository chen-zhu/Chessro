# Chessro 
> Final Project for CS291A - Mixed and Augmented Reality, UCSB, Spring 2020

Chessro is an Augmented Reality Chess Game built for iOS and iPadOS devices (iOS/iPadOS 13.4.0 and above). This project is taking advantage of the following API/Framework & Tools from Apple Developer Portal:

  - RealityKit
  - ARKit
  - UIKit
  - MultipeerConnectivity
  - Reality Composer
  - Xcode

# Features

### Basic Coaching Overlay
- Instruct users to calibrate device camera

![](Images/CoachingOverlay.gif)

### User Interaction
- Tapping 
- Dragging
- Show Movable Grids
- Auto-resume position 
- Accurate Grid Mapping

![](Images/Interaction.gif)

### Basic Human Occlusion
- Devices with **Dual-Camera** or **LIDAR-SCANNER** System can participate in Human Occlusion.

![](Images/Occlusion.gif)

### Multipeer - RealityKit Network Synchronization
- Main gaming logic will be hosted on a HOST Device.
- All other devices can join as PEER and view gaming process.
- Currently, no interaction from PEER devices is allowed
- HOST and PEER/VIEWER devices can be configured under the *GameViewController.swift* file

![](Images/ARNetwork.gif)
