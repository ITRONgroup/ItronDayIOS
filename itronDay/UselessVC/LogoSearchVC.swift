//
//  LogoSearchVC.swift
//  itronDay
//
//  Created by Сережа on 28.02.2022.
//

import UIKit
//import Combine

class LogoSearchVC: UIViewController {

   

    override func viewDidLoad() {
        super.viewDidLoad()
             
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "logoSearch.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
       // self.showSpinner(onView: self.view)   //использовался для загрузки погоды
        
        let date = Date()
        let dateFormatter = DateFormatter()    // Create Date Formatter
        dateFormatter.dateFormat = "dd MMM"  // Set Date/Time Style
        let dateString = dateFormatter.string(from: date)
        print (dateString)
        
        let labelDate = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 150))
        labelDate.center = CGPoint(x: 200, y: 55)
        labelDate.textAlignment = .center
        labelDate.textColor = UIColor.init(hexString: "#11115d")
        labelDate.font = UIFont(name: "ComicSansMS", size: 18)!
        labelDate.text = dateString
        
        self.view.addSubview(labelDate)
        
        let labelTime = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 23))
        labelTime.center = CGPoint(x: 200, y: 134)
        labelTime.textAlignment = .center
        labelTime.textColor = UIColor.init(hexString: "#11115d")
        labelTime.font = UIFont(name: "ComicSansMS", size: 25)!
        labelTime.text = time()

        self.view.addSubview(labelTime)
        
        var timerTime = Timer()
        timerTime = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
                update()
        })
        func update(){
            labelTime.text = time()
        }
        
                    //использовался для загрузки погоды
//        var timer = Timer()
//        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
//                updateCounting()
//        })
//            func updateCounting(){
//                let variable = RightNowView.myWeatherString
//                print ("поход в API погоды")
//                if variable != "" {
//                    self.removeSpinner()
//                    print ("данные получены, выключаем вызыв функции")
//                    timer.invalidate()
//            }
//
//        }
//        let goToARButton = UIButton(frame: CGRect(x: 93, y: 607, width: 220, height: 77))
//        goToARButton.setTitle("", for: .normal)
//        goToARButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
//
//        self.view.addSubview(goToARButton)
                //использовался для загрузки погоды

    }
    
    func time() -> String {
        let time = Date()
        let calendar = Calendar.current
        let hour = String(calendar.component(.hour, from: time))
        let minutes = String(format: "%02d", calendar.component(.minute, from: time))
        let timeString = hour + ":" + minutes
        return timeString
    }
}
                    //использовался для загрузки погоды
//var vSpinner : UIView?
//
//    extension UIViewController {
//        func showSpinner(onView : UIView) {
//            let spinnerView = UIView.init(frame: onView.bounds)
//            spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
//            let ai = UIActivityIndicatorView.init(style: .whiteLarge)
//            ai.startAnimating()
//            ai.center = spinnerView.center
//
//            DispatchQueue.main.async {
//                spinnerView.addSubview(ai)
//                onView.addSubview(spinnerView)
//            }
//
//            vSpinner = spinnerView
//        }
//
//        func removeSpinner() {
//            DispatchQueue.main.async {
//                vSpinner?.removeFromSuperview()
//                vSpinner = nil
//            }
//        }
//    }

