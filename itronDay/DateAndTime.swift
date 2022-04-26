//
//  DateAndTime.swift
//  itronDay
//
//  Created by Сергей Киселев on 24.04.2022.
//

import UIKit

class DateAndTime: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    func dateAndTime() {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
        label.center = CGPoint(x: 200, y: 134)
        label.textAlignment = .center
        label.textColor = UIColor.init(hexString: "#11115d")
        label.font = UIFont(name: "ComicSansMS", size: 25)!
        label.text = time()

        self.view.addSubview(label)
        
        var timerTime = Timer()
        timerTime = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
                update()
        })
        func update(){
            label.text = time()
            print ("nvnjvnr")
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
}
