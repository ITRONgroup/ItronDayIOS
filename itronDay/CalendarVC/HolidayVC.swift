//
//  HolidayVC.swift
//  itronDay
//
//  Created by Сережа on 04.03.2022.
//

import SwiftUI
import UIKit
import Foundation

class HolidayVC: UIViewController {
    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dummyData.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")! as UITableViewCell
//
//        cell.textLabel!.text = dummyData[indexPath.row]
//
//        return cell;
//    }

    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var events: UILabel!
    
    var date: String = ""
    var dateToLabel: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "holiday.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
        let nextButton = UIButton(frame: CGRect(x: 112, y: 746, width: 180, height: 60))
        //nextButton.setTitle("Вернуться", for: .normal)
        //nextButton.backgroundColor = .blue
        nextButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)

        self.view.addSubview(nextButton)
        
        dateLabel.textAlignment = .center
        dateLabel.textColor = UIColor.init(hexString: "#11115d")
        dateLabel.font = UIFont(name: "ComicSansMS", size: 18)!
        dateLabel.text = dateToLabel
        print (dateToLabel)

        var data = readDataFromCSV(fileName: "Events", fileType: "csv")
        data = cleanRows(file: data!)
        let csvRows = csv(data: data!)
        
        print ("vgvhgv")
        print (date)
        print (csvRows[1][0])
        
        for index in 1...366 {
            if (date == csvRows[index][0]){
                
                var event = ["", ""]
                event.insert(csvRows[index][1], at: 0)// = csvRows[index][2] as! String
                //event.insert(csvRows[index+1][2], at: 0)
                print (event)
                var stringEvent = event.joined(separator: "")
                print (stringEvent)
                let result =  stringEvent.components(separatedBy: ["."])
                print (result)
                stringEvent = result.joined(separator: "\n\n")
//                let event = csvRows[index][2]
//                print (event)
                events.text = stringEvent
                events.textColor = .gray
                
            } else {
                
            }
        }
        
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
  
//        
//        var data = readDataFromCSV(fileName: "Events", fileType: "csv")
//        data = cleanRows(file: data!)
//        let csvRows = csv(data: data!)
//        print(csvRows[224])
//        
        
        //        let url = Bundle.main.url(forResource: "Events", withExtension: "csv")!
        
//        func parseCSV (contentsOfURL: URL, encoding: String.Encoding, error: NSErrorPointer) -> [(name:String, detail:String, price: String)]? {
//            // Load the CSV file and parse it
//            let delimiter = ","
//            var items:[(name:String, detail:String, price: String)]?
//
//            if let content = String(contentsOfURL) {
//                items = []
//                let lines:[String] = content.componentsSeparatedByCharactersInSet(NSCharacterSet.newlineCharacterSet) as [String]
//
//                for line in lines {
//                    var values:[String] = []
//                    if line != "" {
//                        // For a line with double quotes
//                        // we use NSScanner to perform the parsing
//                        if line.range(of: "\"") != nil {//rangeOfString("\"") != nil {
//                            var textToScan:String = line
//                            var value:NSString?
//                            var textScanner:Scanner = Scanner(string: textToScan)
//                            while textScanner.string != "" {
//
//                                if (textScanner.string as NSString).substring(to: 1) == "\"" {
//                                    textScanner.scanLocation += 1
//                                    textScanner.scanUpTo("\"", into: &value)
//                                    textScanner.scanLocation += 1
//                                } else {
//                                    textScanner.scanUpTo(delimiter, into: &value)
//                                }
//
//                                // Store the value into the values array
//                                values.append(value as! String)
//
//              // Retrieve the unscanned remainder of the string
//                                //if textScanner.scanLocation < count(textScanner.string) {
//                                    textToScan = (textScanner.string as NSString).substring(from: textScanner.scanLocation + 1)
////                                } else {
////                                    textToScan = ""
////                                }
//                                textScanner = Scanner(string: textToScan)
//                            }
//
//                        // For a line without double quotes, we can simply separate the string
//                        // by using the delimiter (e.g. comma)
//                        } else  {
//                            values = line.components(separatedBy: delimiter)//componentsSeparatedByString(delimiter)
//                        }
//
//                        // Put the values into the tuple and add it to the items array
//                        let item = (name: values[0], detail: values[1], price: values[2])
//                        items?.append(item)
//                    }
//                }
//            }
//
//            return items
//        }
//        if #available(iOS 15, *) {
//            let res = try? DataFrame(contentsOfCSVFile: url)
//            print(res)
//        } else {
//            print("Update your phone")
//        }
        
        //var datada = readFile(HolidayVC())
        //var myData = readFile(inputFile: "Events.svg")
    }
    
//    func fileName() -> String {
//        return URL(fileURLWithPath: self).deletingPathExtension().lastPathComponent
//    }
//
//    func fileExtention() -> String{
//        return URL(fileURLWithPath: self).pathExtension
//    }
    
//    func readFile(inputFile: String) -> String {
//        let fileExtention = "Events" //inputFile.fileExtension()
//        let fileName = ".svg"//inputFile.fileName()
//
//        let fileURL = try! FileManager.default.url(for: .downloadsDirectory, in: .userDomainMask,  appropriateFor: nil, create: true)
//        let inputFile = fileURL.appendingPathComponent(fileName).appendingPathExtension(fileExtention)
//        do{
//            let savedData = try String(contentsOf: inputFile)
//            return savedData
//        } catch {
//            return error.localizedDescription
//        }
//    }
    
@objc func buttonAction(sender: UIButton!) {
        print("Button tapped")
    self.dismiss(animated: true, completion: nil)
    }
    
    func csv(data: String) -> [[String]] {
        var result: [[String]] = []
        let rows = data.components(separatedBy: "\n")
        for row in rows {
            let columns = row.components(separatedBy: ";")
            result.append(columns)
        }
        return result
    }
    
    func readDataFromCSV(fileName:String, fileType: String)-> String!{
            guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
                else {
                    return nil
            }
            do {
                var contents = try String(contentsOfFile: filepath, encoding: .utf8)
                contents = cleanRows(file: contents)
                return contents
            } catch {
                print("File Read Error for file \(filepath)")
                return nil
            }
        }
    
    func cleanRows(file:String)->String{
        var cleanFile = file
        cleanFile = cleanFile.replacingOccurrences(of: "\r", with: "\n")
        cleanFile = cleanFile.replacingOccurrences(of: "\n\n", with: "\n")
        return cleanFile
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


