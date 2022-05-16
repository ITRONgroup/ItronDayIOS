//
//  WarningVC.swift
//  itronDay
//
//  Created by Сережа on 28.02.2022.
//

import UIKit

class WarningVC: UIViewController {

    static var counter = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "warning.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
    
        let button = UIButton(frame: CGRect(x: 90 / 320 * screenSize.width, y: 180 / 840 * screenSize.height, width: 220, height: 86))
        button.setTitle("", for: .normal)
        button.addTarget(self, action: #selector(buttonCounter), for: .touchUpInside)

        self.view.addSubview(button)

       
    }
    @objc func buttonCounter (sender:UIButton){

        WarningVC.counter = WarningVC.counter + 1
        print(WarningVC.counter)


    
    }
}
