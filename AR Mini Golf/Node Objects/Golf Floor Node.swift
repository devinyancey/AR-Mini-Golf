//
//  Golf Floor Node.swift
//  AR Mini Golf
//
//  Created by Devin Yancey on 9/27/18.
//  Copyright © 2018 Devin Yancey. All rights reserved.
//

import Foundation
import ARKit

class FloorNodeManager: NSObject {
    var floorNode: SCNNode!
    static let shared = FloorNodeManager()
    func createNode(planeAnchor: ARPlaneAnchor, color: UIColor) -> SCNNode {
        let planeGeometry = SCNPlane(width: CGFloat(planeAnchor.extent.x), height: CGFloat(planeAnchor.extent.y))
        
        let planeMaterial = SCNMaterial()
        // Set the images here once we get that
        planeMaterial.diffuse.contents = color
        planeGeometry.materials = [planeMaterial]
        
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.y)
        // rotate the plane 90 degrees so it's flat on the floor
        planeNode.transform = SCNMatrix4MakeRotation(-Float.pi / 2, 1, 0, 0)
        floorNode = planeNode
        return floorNode
    }
    
    func updateFloorNode(planeAnchor: ARPlaneAnchor) {
        guard let planeGeometry = self.floorNode.geometry as? SCNPlane else { return }
        planeGeometry.width = CGFloat(planeAnchor.extent.x)
        planeGeometry.height = CGFloat(planeAnchor.extent.y)
        self.floorNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z)
    }
    
    
}
