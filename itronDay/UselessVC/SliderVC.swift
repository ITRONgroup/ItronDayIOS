//
//  SliderVC.swift
//  itronDay
//
//  Created by Sergey on 23.02.2022.
//

import UIKit
import Foundation

class SliderVC: UIViewController {
   
    //@IBOutlet var arView: ARView!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Slider.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let backButton = UIButton(frame: CGRect(x: 88, y: 628, width: 236, height: 82))
        //backButton.backgroundColor = .blue
        backButton.setTitle("перейти к AR", for: .normal)
        backButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(backButton)
    }

@objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    let story = UIStoryboard(name: "Main", bundle: nil)
    let controller = story.instantiateViewController(withIdentifier: "ARVC") as! ViewController
    controller.modalPresentationStyle = .fullScreen
    self.present(controller, animated: true, completion: nil)
    }
    
        
}

