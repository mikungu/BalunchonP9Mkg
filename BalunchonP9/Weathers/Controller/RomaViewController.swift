//
//  RomaViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 08/02/23.
//

import UIKit

class RomaViewController: UIViewController, WeatherModelDelegate {
    
    
    @IBOutlet weak var mainRM: UILabel!
    
    @IBOutlet weak var descriptionRM: UILabel!
    
    @IBOutlet weak var iconWeatherRM: UIImageView!
    
    
    let weather = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weather.delegate = self
        
        weather.getWeather(city: "roma")
        
    }
    
    func showWeather (_ value: Weathers) {
                    print ("\(value)")
        mainRM.text = " Umidità : \(value.main.humidity) %  Temperatura : \(value.main.temp) ° "
        descriptionRM.text = " Descrizione : \(value.weather[0].description) \n Id : \(value.weather[0].id)"
        displayWeatherIcon(weatherData: value)
        
                }
    func showError (_ error: APIError) {
               print ("\(error)")
        self.displayAlert(title: error, message: "The request failed, please try again !", preferredStyle: .alert)
           }
    
    private func displayWeatherIcon(weatherData: Weathers) {
        let weatherCode = weatherData.weather[0].id
        
        switch weatherCode {
        case 200...299:
            iconWeatherRM.image = #imageLiteral(resourceName: "storm")
        case 300...399:
            iconWeatherRM.image = #imageLiteral(resourceName: "rain")
        case 500...599:
            iconWeatherRM.image = #imageLiteral(resourceName: "rain")
        case 600...699:
            iconWeatherRM.image = #imageLiteral(resourceName: "snow")
        case 700...799:
            iconWeatherRM.image = #imageLiteral(resourceName: "atmosphere") 
        case 800:
            iconWeatherRM.image = #imageLiteral(resourceName: "clear sky")
        case 801...899:
            iconWeatherRM.image = #imageLiteral(resourceName: "clouds")
        default:
            break
        }
    }
    

}
