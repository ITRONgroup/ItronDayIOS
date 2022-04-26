//
//  CalendarAlertVC.swift
//  itronDay
//
//  Created by Сергей Киселев on 03.03.2022.
//

import UIKit

class CalendarAlertVC: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "CalendarAlertVC.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let nextButton = UIButton(frame: CGRect(x: 81, y: 600, width: 240, height: 107))
        nextButton.setTitle("", for: .normal)
        nextButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(nextButton)
        
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
        
        let labelTime = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 25))
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

    }
    
    func time() -> String {
        let time = Date()
        let calendar = Calendar.current
        let hour = String(calendar.component(.hour, from: time))
        let minutes = String(format: "%02d", calendar.component(.minute, from: time))
        let timeString = hour + ":" + minutes
        return timeString
    }


@objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    let story = UIStoryboard(name: "Main", bundle: nil)
    let controller = story.instantiateViewController(withIdentifier: "CalendarVC") as! CalendarVC
    controller.modalPresentationStyle = .fullScreen
    self.present(controller, animated: true, completion: nil)
    }
}
