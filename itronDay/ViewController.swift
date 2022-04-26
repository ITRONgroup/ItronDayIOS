//
//  ViewController.swift
//  itronDays
//
//  Created by Сергей Киселев on 31.03.2022.
//

import UIKit
import SceneKit
import ARKit

class ViewController: UIViewController{//}, ARSCNViewDelegate {

    
    @IBOutlet var sceneView: ARSCNView!
    
    // Add configuration variables here:
    private var imageConfiguration: ARImageTrackingConfiguration?
    private var worldConfiguration: ARWorldTrackingConfiguration?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set the view's delegate
        sceneView.delegate = self
        
        let scene = SCNScene()
        
        // Show statistics such as fps and timing information
        sceneView.showsStatistics = true
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()

        cameraNode.position = SCNVector3(x:0, y: 0, z: 0)

        scene.rootNode.addChildNode(cameraNode)
        
        
        //заккоментировать, чтоб отображался только по логотипу!!!
        if ( WarningVC.counter == 5 ) {
            let cubeNode = cubeNode()
            cubeNode.position = SCNVector3(x: 0, y: -1, z: -1)
            scene.rootNode.addChildNode(cubeNode)
        }
        //Конец комментария
        
        // Set the scene to the view
        sceneView.scene = scene
        
        setupObjectDetection()
        
        sceneView.allowsCameraControl = true
        
        let buttonTextColor: UIColor
        buttonTextColor = UIColor.init(hexString: "#11115d")
        
        let backButton = UIButton(frame: CGRect(x: 88, y: 628, width: 236, height: 82))
        backButton.setTitle("Вернуться", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "ComicSansMS", size: 25)!
        backButton.setTitleColor(buttonTextColor, for: .normal)
        backButton.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)

        self.view.addSubview(backButton)
                
        let calendarButton = UIButton(frame: CGRect(x: 106, y: 535, width: 200, height: 70))
        calendarButton.setTitle("Календарь", for: .normal)
        calendarButton.titleLabel?.font = UIFont(name: "ComicSansMS", size: 25)!
        calendarButton.setTitleColor(buttonTextColor, for: .normal)
        calendarButton.addTarget(self, action: #selector(calendarButtonAction), for: .touchUpInside)

        self.view.addSubview(calendarButton)
        
    }
    
    deinit {
        print ("BYE")
    }
    
    override func viewWillAppear(_ animated: Bool) {
      super.viewWillAppear(animated)
      if let configuration = worldConfiguration {
        //sceneView.debugOptions = .showFeaturePoints
        sceneView.session.run(configuration)
      }
    }

    override func viewWillDisappear(_ animated: Bool) {
      super.viewWillDisappear(animated)
      sceneView.session.pause()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    // MARK: - ARSCNViewDelegate
    
/*
    // Override to create and configure nodes for anchors added to the view's session.
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
     
        return node
    }
*/
    
//    func session(_ session: ARSession, didFailWithError error: Error) {
//        // Present an error message to the user
//
//    }
    
    func sessionWasInterrupted(_ session: ARSession) {
        // Inform the user that the session has been interrupted, for example, by presenting an overlay
        
    }
    
    func sessionInterruptionEnded(_ session: ARSession) {
        // Reset tracking and/or remove existing anchors if consistent tracking is required
        
    }
    
    private func setupImageDetection() {
      imageConfiguration = ARImageTrackingConfiguration()

      guard let referenceImages = ARReferenceImage.referenceImages(
        inGroupNamed: "AR Images", bundle: nil) else {
          fatalError("Missing expected asset catalog resources.")
      }
      imageConfiguration?.trackingImages = referenceImages
    }

    private func setupObjectDetection() {
      worldConfiguration = ARWorldTrackingConfiguration()


      guard let referenceImages = ARReferenceImage.referenceImages(
        inGroupNamed: "AR Images", bundle: nil) else {
          fatalError("Missing expected asset catalog resources.")
      }
      worldConfiguration?.detectionImages = referenceImages
    }

  }

extension ViewController: ARSessionDelegate {
  func session(_ session: ARSession, didFailWithError error: Error) {
    guard
      let error = error as? ARError,
      let code = ARError.Code(rawValue: error.errorCode)
      else { return }
    //instructionLabel.isHidden = false
    switch code {
    case .cameraUnauthorized:
        print( "Camera tracking is not available. Please check your camera permissions." )
    default:
      print( "Error starting ARKit. Please fix the app and relaunch." )
    }
  }

  func session(_ session: ARSession, cameraDidChangeTrackingState camera: ARCamera) {
    switch camera.trackingState {
    case .limited(let reason):
      //instructionLabel.isHidden = false
      switch reason {
      case .excessiveMotion:
          print("Too much motion! Slow down.")
      case .initializing, .relocalizing:
          print("ARKit is doing it's thing. Move around slowly for a bit while it warms up.")
      case .insufficientFeatures:
          print("Not enough features detected, try moving around a bit more or turning on the lights.")
      }
    case .normal:
        print( "Point the camera at a logo.")
    case .notAvailable:
      //instructionLabel.isHidden = false
        print("Camera tracking is not available.")
    }
  }
}


extension ViewController: ARSCNViewDelegate {
  func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
    DispatchQueue.main.async { //self.instructionLabel.isHidden = true
        print ("All is OK")
    }
    if let imageAnchor = anchor as? ARImageAnchor {
      handleFoundImage(imageAnchor, node)
    } else if let objectAnchor = anchor as? ARObjectAnchor {
      handleFoundObject(objectAnchor, node)
    }
  }

    private func handleFoundImage(_ imageAnchor: ARImageAnchor, _ node: SCNNode) {
      let name = imageAnchor.referenceImage.name!
      print("you found a \(name) image")

        let cubeNode = cubeNode()
        cubeNode.position = SCNVector3(x: 0, y: -0.5, z: 0)
        node.addChildNode(cubeNode)
    }

    private func handleFoundObject(_ objectAnchor: ARObjectAnchor, _ node: SCNNode) {
      // 1
      let name = objectAnchor.referenceObject.name!
      print("You found a \(name) object")

    }


@objc func backButtonAction(sender: UIButton!) {
    print("Button tapped")
        //self.dismiss(animated: true, completion: nil)
    self.presentingViewController?.presentingViewController?.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }


    @objc func calendarButtonAction(sender: UIButton!) {
        print("Calendar Button tapped")
        
//            let alertController = UIAlertController(title: "В разработке", message: "", preferredStyle: .alert)
//                    let doneAction = UIAlertAction(title: "Ok", style: .default)
//                    alertController.addAction(doneAction)
//                    self.present(alertController, animated: true, completion: nil)
    let vc = CalendarAlertVC() //change this to your class name
    vc.modalPresentationStyle = .fullScreen
    self.present(vc, animated: true, completion: nil)
    //self.dismiss(animated: true, completion: nil)
    }
}


