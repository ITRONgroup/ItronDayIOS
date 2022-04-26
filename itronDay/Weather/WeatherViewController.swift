//
//  WeatherViewController.swift
//  itronDay
//
//  Created by Сережа on 16.03.2022.
//

import UIKit
import MapKit

class WeatherViewController: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var rightNowView: RightNowView!
    
    var city = ""
    var weatherResult: Result?
    var locationManger: CLLocationManager!
    var currentlocation: CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clearAll()
        getLocation()

    }
    
    func clearAll() {
        //rightNowView.image()
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "doYouKnow.png")
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        self.view.insertSubview(backgroundImage, at: 0)
        
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
        labelTime.center = CGPoint(x: 200, y: 137)
        labelTime.textAlignment = .center
        labelTime.textColor = UIColor.init(hexString: "#11115d")
        labelTime.font = UIFont(name: "ComicSansMS", size: 25)!
        labelTime.text = time()

        self.view.addSubview(labelTime)
        
        var timer = Timer()
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { _ in
                updateCounting()
        })
        func updateCounting(){
            labelTime.text = time()
        }
    }
    
    func getWeather() {
        NetworkService.shared.getWeather(onSuccess: { (result) in
            self.weatherResult = result
            self.updateView()
            
        }) { (errorMessage) in
            debugPrint(errorMessage)
        }
    }
    
    func updateView() {
        guard let weatherResult = weatherResult else {
            return
        }
        
        rightNowView.updateView(currentWeather: weatherResult.current, city: city)
    }
    
    func getLocation() {
       
        if (CLLocationManager.locationServicesEnabled()) {
            locationManger = CLLocationManager()
            locationManger.delegate = self
            locationManger.desiredAccuracy = kCLLocationAccuracyBest
            locationManger.requestWhenInUseAuthorization()
            locationManger.requestLocation()
        }
        
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.currentlocation = location
            
            let latitude: Double = self.currentlocation!.coordinate.latitude
            let longitude: Double = self.currentlocation!.coordinate.longitude
            
            NetworkService.shared.setLatitude(latitude)
            NetworkService.shared.setLongitude(longitude)
            
            let geocoder = CLGeocoder()
            geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                }
                if let placemarks = placemarks {
                    if placemarks.count > 0 {
                        let placemark = placemarks[0]
                        if let city = placemark.locality {
                            self.city = city
                        }
                    }
                }
            }
            
            getWeather()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        debugPrint(error.localizedDescription)
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
