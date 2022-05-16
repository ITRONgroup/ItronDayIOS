//
//  DoYouKnowVC.swift
//  itronDay
//
//  Created by Сережа on 28.02.2022.
//

import UIKit

class DoYouKnowVC: UIViewController {
   
    //@IBOutlet var arView: ARView!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "doYouKnow.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "startScreen.png")!)
        let nextButton = UIButton(frame: CGRect(x: 173 / 320 * screenSize.width, y: 444 / 840 * screenSize.height, width: 209, height: 75))
        nextButton.setTitle("", for: .normal)
        nextButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(nextButton)

    }

@objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    let story = UIStoryboard(name: "Main", bundle: nil)
    let controller = story.instantiateViewController(withIdentifier: "LogoSearchVC") as! LogoSearchVC
    controller.modalPresentationStyle = .fullScreen
    self.present(controller, animated: true, completion: nil)
    }
}
