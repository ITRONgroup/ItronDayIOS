//
//  cubeNode.swift
//  itronDays
//
//  Created by Сергей Киселев on 31.03.2022.
//

import SceneKit

var temp = RightNowView.myWeatherString
let city = RightNowView.city

class cubeNode: SCNNode {
    override init() {
        super.init()
        self.geometry = SCNBox.init(width: 0.3,  height: 0.3, length: 0.3, chamferRadius: 0.05)
        
        
        //MARK: грань куба "Время"
        
        let timeMaterial = SCNMaterial()
        
        let time = Date()
        let calendar = Calendar.current
        let hour = String(calendar.component(.hour, from: time))
        let minutes = String(format: "%02d", calendar.component(.minute, from: time))
        let timeString = hour + ":" + minutes
        
        let timeText = textInImage(drawText: timeString, inImage: UIImage(named:"Time.png")!, x: 600, y: 1100, width: 1000, height: 500, size: 250, color: "#141743")
        timeMaterial.diffuse.contents = timeText//UIImage(named: "Time")
        timeMaterial.locksAmbientWithDiffuse = true;

        //MARK: грань куба "Погода"
        
        
        let weatherMaterial  = SCNMaterial()
        weatherMaterial.diffuse.contents = UIImage(named: "Weather")
        
        var timer = Timer()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { _ in
            updateWeather()
        })
        func updateWeather(){
                let variable = RightNowView.myWeatherString
                print ("поход в API погоды")
                if variable != "" {
                    let weather = city + "\n" + temp
                    let weatherText = textInImage(drawText: weather, inImage: UIImage(named:"Weather.png")!, x: 450, y: 700, width: 1000, height: 1000, size: 200, color: "#141743")
                    weatherMaterial.diffuse.contents = weatherText
                    print ("данные получены, выключаем вызыв функции")
                    timer.invalidate()
                }
            }
        weatherMaterial.locksAmbientWithDiffuse = true;

        //MARK: грань куба "Дата"
        
        let date = Date()
        let dateFormatter = DateFormatter()    // Create Date Formatter
        dateFormatter.dateFormat = "dd.MM.yy"  // Set Date/Time Style
        let dateString = dateFormatter.string(from: date)
           
        print (dateString)
        
        let dateText = textInImage(drawText: dateString, inImage: UIImage(named:"Date.png")!, x: 400, y: 1000, width: 1400, height: 500, size: 250, color: "#141743")
        
        let dateMaterial = SCNMaterial()
        dateMaterial.diffuse.contents = dateText
        dateMaterial.locksAmbientWithDiffuse   = true;
        
        //MARK: грань куба "Цитата"
        
        let numberQuotes = Int.random(in: 0...160)
        let numberStrQuotes = String(numberQuotes)
        let quotesData = readDataFromCSV(fileName: "Quotes", fileType: "csv")
        let quoteCsvRows = csv(data: quotesData!)
        
        var stringQuote = "Цитаты"
        var stringAutor = ""
        for index in 1...259 {
            if (numberStrQuotes == quoteCsvRows[index][0]){
                let counter = quoteCsvRows[index].count
                print(counter)
                switch counter {
                case 2:
                    print ("случай не обработан")
                    stringQuote = quoteCsvRows[index][1]
                case 3:
                    stringQuote = quoteCsvRows[index][1]
                case 4:
                    stringQuote = quoteCsvRows[index][1] + "," + quoteCsvRows[index][2]
                case 5:
                    stringQuote = quoteCsvRows[index][1] + "," + quoteCsvRows[index][2] + "," + quoteCsvRows[index][3]
                case 6:
                    stringQuote = quoteCsvRows[index][1] + "," + quoteCsvRows[index][2] + "," + quoteCsvRows[index][3] + "," + quoteCsvRows[index][4]
                case 7:
                    stringQuote = quoteCsvRows[index][1] + "," + quoteCsvRows[index][2] + "," + quoteCsvRows[index][3] + "," + quoteCsvRows[index][4] + "," + quoteCsvRows[index][5]
                case 8:
                    stringQuote = quoteCsvRows[index][1] + "," + quoteCsvRows[index][2] + "," + quoteCsvRows[index][3] + "," + quoteCsvRows[index][4] + "," + quoteCsvRows[index][5] + "," + quoteCsvRows[index][6]
                default:
                    print ("случай не обработан")
                    stringQuote = quoteCsvRows[index][1]
                }
                stringAutor = quoteCsvRows[index].last!
                } else {
            
                }
            }
        
        var quoteText = textInImage(drawText: stringQuote, inImage: UIImage(named:"Quote.png")!, x: 250, y: 650, width: 1500, height: 850, size: 110, color: "#bf8cf1")
        
        quoteText = textInImage(drawText: stringAutor, inImage: quoteText, x: 700, y: 1500, width: 1000, height: 250, size: 80, color: "#bf8cf1")
        
        let quoteMaterial = SCNMaterial()
        quoteMaterial.diffuse.contents = quoteText
        
        //quoteMaterial.diffuse.contents = UIImage(named: "Quote")
        quoteMaterial.locksAmbientWithDiffuse = true;

        //MARK: грань куба "Праздники"

        let eventsData = readDataFromCSV(fileName: "Events", fileType: "csv")
        let eventsCsvRows = csv(data: eventsData!)
               
        var stringEvent = "Праздники"

        let dateEventsFormatter = DateFormatter()    // Create Date Formatter
        dateEventsFormatter.dateFormat = "dd.MM"  // Set Date/Time Style
        let dateEventsString = dateEventsFormatter.string(from: date)
        
        print ("vgvhgv")
           
        print (dateEventsString)
        
        for index in 1...366 {
            if (dateEventsString == eventsCsvRows[index][0]){
                var event = ["", ""]
                event.insert(eventsCsvRows[index][1], at: 0)// = csvRows[index][2] as! String
                //event.insert(csvRows[index+1][2], at: 0)
                print (event)
                stringEvent = event.joined(separator: "")
                print (stringEvent)
                let result =  stringEvent.components(separatedBy: ["."])
                print (result)
                stringEvent = result.joined(separator: "\n\n")
                       
                } else {
                       
                }
            }
        
        let eventText = textInImage(drawText: stringEvent, inImage: UIImage(named:"Events.png")!, x: 280, y: 380, width: 1500, height: 1500, size: 125, color: "#060667")
        
        let eventsMaterial = SCNMaterial()
        eventsMaterial.diffuse.contents = eventText
        eventsMaterial.locksAmbientWithDiffuse = true;
        
        //MARK: грань куба "Факты"
        
        let number = Int.random(in: 0...160)
        let numberStr = String(number)
        let factsData = readDataFromCSV(fileName: "Facts", fileType: "csv")
        let factsCsvRows = csv(data: factsData!)
                
        var stringFacts = "Факты"
        for index in 1...164 {
            if (numberStr == factsCsvRows[index][1]){
                let counter = factsCsvRows[index].count
                print ("факты")
                print(counter)
                switch counter {
                case 2:
                    print ("случай не обработан")
                    stringFacts = factsCsvRows[index][2]
                case 3:
                    stringFacts = factsCsvRows[index][2]
                case 4:
                    stringFacts = factsCsvRows[index][2] + "," + factsCsvRows[index][3]
                case 5:
                    stringFacts = factsCsvRows[index][2] + "," + factsCsvRows[index][3] + "," + factsCsvRows[index][4]
                case 6:
                    stringFacts = factsCsvRows[index][2] + "," + factsCsvRows[index][3] + "," + factsCsvRows[index][4] + "," + factsCsvRows[index][5]
                case 7:
                    stringFacts = factsCsvRows[index][1] + "," + factsCsvRows[index][2] + "," + factsCsvRows[index][3] + "," + factsCsvRows[index][4] + "," + factsCsvRows[index][5] + "," + factsCsvRows[index][6]
                default:
                    print ("случай не обработан")
                    stringFacts = factsCsvRows[index][1]
                }
                
            } else {
            
        }
    }
//            var counter = stringFacts.count
//            print (counter)
//            let factsLimited = String(stringFacts.enumerated().map { $0 > 0 && $0 % 25 == 0 ? ["\n", $1] : [$1]}.joined())    //ограничение символов в строке
//            print (factsLimited)
//
        let factText = textInImage(drawText: stringFacts, inImage: UIImage(named:"Fact.png")!, x: 250, y: 800, width: 1500, height: 1000, size: 120, color: "#050667")
        
        let factMaterial = SCNMaterial()
        factMaterial.diffuse.contents = factText//UIImage(named: "Fact")
        factMaterial.locksAmbientWithDiffuse   = true;


        geometry!.materials =  [timeMaterial,  weatherMaterial,    quoteMaterial,
                                eventsMaterial, dateMaterial, factMaterial];
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func textInImage(drawText text: String, inImage image: UIImage, x: Int, y: Int, width: Int, height: Int, size size: Int, color color: String) -> UIImage {
        let textColor = UIColor(hexString: color)//UIColor.red
        let textFont = UIFont(name: "ComicSansMS", size: CGFloat(size))!

        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

        //let rect = CGRect(origin: point, size: image.size)
        text.draw(in: CGRect(x: x, y: y, width: width, height: height), withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
        
    }
}

func readDataFromCSV(fileName:String, fileType: String)-> String!{
    guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
                else {
                    return nil
            }
            do {
                var contents = try String(contentsOfFile: filepath, encoding: .utf8)
                return contents
            } catch {
                print("File Read Error for file \(filepath)")
                return nil
            }
        }
    
//func csv(data: String, typeCSV: String) -> [[String]] {
//        var result: [[String]] = []
//        let rows = data.components(separatedBy: "\n")
//        var columnsRes = ""
//        for row in rows {
//            var columns = row.components(separatedBy: ",")//(?=(?:[^\"]*\'[^\"]*\')*[^\"]*$)")
//            result.append(columns)
//            print (columns)
//            print (columns.last )
//            let num = columns.count
//            print (num)
//
//            switch typeCSV {
//                case "Events":
//                    print("Переменная равна Events")
//                case "Facts":
//                    print("Переменная равна Facts")
//                case "Quotes":
//                    print("Переменная равна Quotes")
//                    switch num {
//                    case 3:
//                        columnsRes = columns[1] + "," + columns[2]
//                        print ("nhfkzkz")
//                        print (columnsRes)
//                    case 4:
//                        print (columnsRes)
//                       // columnsRes = columns[num-3] + "," + columns[num-2]
//                    default:
//                        print ("не входит в кейс")
//                    }
//                default:
//                    print("не удалось узнать тип")
//            }
//
//            print (columnsRes)
//
//            columns.append(columnsRes)
//        }
//        print (columnsRes)
//        print ("какой-то бред")
//        print (result[2])
//        return result
//    }

func csv(data: String) -> [[String]] {
    var result: [[String]] = []
    let rows = data.components(separatedBy: "\n")
    for row in rows {
        let columns = row.components(separatedBy: ",")
        result.append(columns)
    }
    return result
}


    extension UIColor {
        convenience init(hexString: String) {
            let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
            var int = UInt64()
            Scanner(string: hex).scanHexInt64(&int)
            let a, r, g, b: UInt64
            switch hex.count {
            case 3: // RGB (12-bit)
                (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
            case 6: // RGB (24-bit)
                (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
            case 8: // ARGB (32-bit)
                (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
            default:
                (a, r, g, b) = (255, 0, 0, 0)
            }
            self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
        }
    }
    

