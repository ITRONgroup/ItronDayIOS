//
//  CalendarVC.swift
//  itronDay
//
//  Created by Сережа on 28.02.2022.
//

import UIKit

class CalendarVC: UIViewController {


//    @IBOutlet weak var startDateTextField: UITextField!
    @IBOutlet weak var dateTextField: UIDatePicker!
    
    public var date:String = "какая-то дата"
    public var dateToLabel:String = "какая-то дата"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "сalendar.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let nextButton = UIButton(frame: CGRect(x: 40 / 320 * screenSize.width, y: 601 / 840 * screenSize.height, width: 310, height: 100))
        nextButton.setTitle("Смотреть праздники", for: .normal)
        nextButton.titleLabel?.font = UIFont(name: "ComicSansMS", size: 25)!
        let buttonTextColor = UIColor.init(hexString: "#11115d")
        nextButton.setTitleColor(buttonTextColor, for: .normal)
        nextButton.setBackgroundImage(UIImage(named: "warningButton.png"), for: .normal)
        nextButton.addTarget(self, action: #selector(dateSelected), for: .touchUpInside)

        self.view.addSubview(nextButton)
        let backButton = UIButton(frame: CGRect(x: 80 / 320 * screenSize.width, y: 720 / 840 * screenSize.height, width: 200, height: 90))
        backButton.setTitle("Вернуться", for: .normal)
        backButton.titleLabel?.font = UIFont(name: "ComicSansMS", size: 25)!
        backButton.setTitleColor(buttonTextColor, for: .normal)
        backButton.setBackgroundImage(UIImage(named: "warningButton.png"), for: .normal)
        backButton.addTarget(self, action: #selector(backbuttonAction), for: .touchUpInside)

        self.view.addSubview(backButton)
        
        let date = Date()
        let dateFormatter = DateFormatter()    // Create Date Formatter
        dateFormatter.dateFormat = "dd MMM"  // Set Date/Time Style
        let dateString = dateFormatter.string(from: date)
        print (dateString)
        
        let labelDate = UILabel(frame: CGRect(x: 0, y: 0, width: 110, height: 110))
        labelDate.center = CGPoint(x: 200, y: 55)
        labelDate.textAlignment = .center
        labelDate.backgroundColor = UIColor(patternImage: UIImage(named: "Бумажка")!)
        labelDate.textColor = UIColor.init(hexString: "#11115d")
        labelDate.font = UIFont(name: "ComicSansMS", size: 18)!
        labelDate.text = dateString
        
        self.view.addSubview(labelDate)
        
        let labelTime = UILabel(frame: CGRect(x: 0, y: 0, width: 130, height: 50))
        labelTime.center = CGPoint(x: 200, y: 134)
        labelTime.textAlignment = .center
        labelTime.backgroundColor = UIColor(patternImage: UIImage(named: "место под время")!)
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
        
        dateTextField.datePickerMode = .date

            if #available(iOS 14, *) {
                dateTextField.tintColor = .systemBlue
                let margins = view.layoutMarginsGuide
                dateTextField.topAnchor.constraint(equalTo: margins.topAnchor, constant: 140 / 840 * screenSize.height).isActive = true
//                dateTextField.backgroundColor = .white
                dateTextField.calendar.veryShortWeekdaySymbols
                dateTextField.overrideUserInterfaceStyle = .light
                dateTextField.addTarget(self, action: #selector(dateSelected), for: .valueChanged)
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

//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            guard segue.identifier == "showSecond" else { return }
//            guard let destination = segue.destination as? HolidayVC else { return }
//            destination.date = "Передача данных"
//        }
    
    @objc func dateSelected() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM"
        date = dateFormatter.string(from: dateTextField.date)
        dateFormatter.dateFormat = "dd MMM"
        dateToLabel = dateFormatter.string(from: dateTextField.date)
        print (date)
        let story = UIStoryboard(name: "Main", bundle: nil)
        let controller = story.instantiateViewController(withIdentifier: "HolidayVC") as! HolidayVC
        controller.modalPresentationStyle = .fullScreen
        controller.date = date
        controller.dateToLabel = dateToLabel
        self.present(controller, animated: true, completion: nil)
    }
    
@objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    let story = UIStoryboard(name: "Main", bundle: nil)
    let controller = story.instantiateViewController(withIdentifier: "HolidayVC") as! HolidayVC
    controller.modalPresentationStyle = .fullScreen
    self.present(controller, animated: true, completion: nil)
    }
    
    
@objc func backbuttonAction(sender: UIButton!) {
        print("Button tapped")
//    let story = UIStoryboard(name: "Main", bundle: nil)
//    let controller = story.instantiateViewController(withIdentifier: "ARVC") as! ViewController
//    controller.modalPresentationStyle = .fullScreen
//    self.present(controller, animated: true, completion: nil)
    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


