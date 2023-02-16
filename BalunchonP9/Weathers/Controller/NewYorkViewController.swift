//
//  NewYorkViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 08/02/23.
//

import UIKit

class NewYorkViewController: UIViewController, WeatherModelDelegate {
   
    
    
    
    @IBOutlet weak var mainNY: UILabel!
    
    @IBOutlet weak var descriptionNY: UILabel!
   
    @IBOutlet weak var iconWeather: UIImageView!
    
    
    let weather = WeatherModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.weather.delegate = self
        
        weather.getWeather(city: "New+York")
        
    }
    
    func showWeather (_ value: Weathers) {
        print ("\(value)")
        mainNY.text = " Humidity: \(value.main.humidity) %  Temperature : \(value.main.temp) ° "
        descriptionNY.text = " Description: \(value.weather[0].description) \n Id : \(value.weather[0].id)"
        displayWeatherIcon(weatherData: value)
        
        
                }
    
    func showError (_ error: APIError) {
               print ("\(error)")
        self.displayAlert(title: error, message: "La richiesta non è andata a buon fine, riprova !", preferredStyle: .alert)
           }
    
    private func displayWeatherIcon(weatherData: Weathers) {
        let weatherCode = weatherData.weather[0].id
        
        switch weatherCode {
        case 200...299:
            iconWeather.image = #imageLiteral(resourceName: "storm")
        case 300...399:
            iconWeather.image = #imageLiteral(resourceName: "rain")
        case 500...599:
            iconWeather.image = #imageLiteral(resourceName: "rain")
        case 600...699:
            iconWeather.image = #imageLiteral(resourceName: "snow")
        case 700...799:
            iconWeather.image = #imageLiteral(resourceName: "atmosphere")
        case 800:
            iconWeather.image = #imageLiteral(resourceName: "clear sky")
        case 801...899:
            iconWeather.image = #imageLiteral(resourceName: "clouds")
        default:
            break
        }
    }
    
}
