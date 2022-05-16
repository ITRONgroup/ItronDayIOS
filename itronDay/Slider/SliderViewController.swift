//
//  SliderViewController.swift
//  itronDay
//
//  Created by Сережа on 09.02.2022.
//
import UIKit

let screenSize: CGRect = UIScreen.main.bounds

class SliderViewController: UIViewController, SlideToOpenDelegate {
    
    @IBOutlet weak var SliderView: UIView!
    
    lazy var slideToOpen: SlideToOpenView = {
        let slide = SlideToOpenView(frame: CGRect(x: 40 / 320 * screenSize.width, y: 590 / 840 * screenSize.height, width: 302, height: 120))
        slide.sliderViewTopDistance = 0
        slide.sliderCornerRadius = 58
        slide.showSliderText = true
        slide.thumbnailColor = UIColor(hexString: "#201e1b")//UIColor(red:141.0/255, green:19.0/255, blue:65.0/255, alpha:1.0)
        slide.slidingColor = UIColor(hexString: "#b5da6a")
        slide.textColor = UIColor.black
        slide.sliderBackgroundColor = UIColor(hexString: "#ff4e81")
        slide.delegate = self
        
        return slide
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "Slider.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        
        self.view.addSubview(slideToOpen)
    }
    
    // MARK: MTSlideToOpenDelegate
        func SlideToOpenDelegateDidFinish(_ sender: SlideToOpenView) {
//        let alertController = UIAlertController(title: "", message: "Done!", preferredStyle: .alert)
//        let doneAction = UIAlertAction(title: "Okay", style: .default) { (action) in
//            sender.resetStateWithAnimation(false)
//        }
//        alertController.addAction(doneAction)
//        self.present(alertController, animated: true, completion: nil)
            let vc = StartScreenVC() //change this to your class name
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
            
    }
}
