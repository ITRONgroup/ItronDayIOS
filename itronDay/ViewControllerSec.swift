//
//  ViewController.swift
//  itronDay
//
//  Created by Sergey on 04.02.2022.
//

import UIKit
import RealityKit

class ViewControllerSec: UIViewController {
   
    @IBOutlet var arView: ARView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
       
        //setupArView()
       
        // Load the "Box" scene from the "Experience" Reality File
        let boxAnchor = try! Experience.loadBox()
       
        
//        let BoxAnchor = try! Experience.loadBox()
//        arView.scene.anchors.append(BoxAnchor)
//
//        BoxAnchor.name = "mySCENE"
//        BoxAnchor.children[0].name = "myANCHOR"
//        BoxAnchor.children[0].children[0].name = "myENTITIES"
//
//        print(BoxAnchor)   //hierarchy inference

        //let BoxEntity = BoxAnchor.box
        //BoxEntity!.position.x = -0.2
            
      
        // Add the box anchor to the scene
        arView.scene.anchors.append(boxAnchor)
        
    }
}
