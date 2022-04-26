//
//  RightNowView.swift
//  itronDay
//
//  Created by Сережа on 16.03.2022.
//
import UIKit

class RightNowView: UIView {

    static var myWeatherString = String()
    static var city = String()
    
    func image() {
    }
    
    func clear() {
    }
    
    func updateView(currentWeather: Current, city: String) {
        let city = String(city)
        RightNowView.city = city
        let temp =  String(Int(currentWeather.temp))
        print (temp)
        RightNowView.myWeatherString = temp + " °C"
    }

}
