//
//  NewYorkViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 08/02/23.
//

import UIKit

class NewYorkViewController: UIViewController, WeatherModelDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    //MARK: -Outlets
    @IBOutlet weak var welcomeLabel: UILabel!
    
    @IBOutlet weak var mainNY: UILabel!
    
    @IBOutlet weak var descriptionNY: UILabel!
    
    @IBOutlet weak var iconWeather: UIImageView!
    
    @IBOutlet weak var romeWeatherButton: UIButton!
    
    @IBOutlet weak var citiesUSPickerView: UIPickerView!
    
    @IBOutlet weak var showWeather: UIButton!
    
    
    
    //MARK: -Property
    //an instance of WeatherModel
    let weather = WeatherModel()
    //MARK: -Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weather.delegate = self
        weather.getWeather(city: "New+York")
        citiesUSPickerView.selectRow(34, inComponent: 0, animated: true)
    }
    //MARK: -Delegate
    func showWeather (_ value: Weathers) {
        print ("\(value)")
        mainNY.text = " Humidity: \(value.main.humidity) %  Temperature : \(value.main.temp) ° "
        descriptionNY.text = " Description: \(value.weather[0].description) \n Id : \(value.weather[0].id)"
        welcomeLabel.text = " Welcome to \(value.name)"
        displayWeatherIcon(weatherData: value)
    }
    func showError (_ error: APIError) {
        print ("\(error)")
        switch error {
        case .url:
            self.displayAlert(title: "Oups, Error!", message: "The request failed, There is a technical problem with url, Please try later !", preferredStyle: .alert)
        case .invalidData:
            self.displayAlert(title: "Oups, Error!", message: "The request failed due to a technical problem, The Data is invalid, Please try later !", preferredStyle: .alert)
        case .responseCode:
            self.displayAlert(title: "Oups, Error!", message: "The request failed due to a technical problem with a responseCode, Please try later !", preferredStyle: .alert)
        case .parsing:
            self.displayAlert(title: "Oups, Error!", message: "The request failed, There is a technical problem with convertion's data, Please try later !", preferredStyle: .alert)
        default:
            break
        }
    }
    //MARK: -Private
    //function to display the icon from the Assets
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
    
    //MARK: -Actions
    @IBAction func showRomaWeather(_ sender: Any) {
        weather.getWeather(city: "Rome")
        welcomeLabel.text = "Benvenuto Roma"
        // romeWeatherButton.isHidden = true
        view.backgroundColor = .green
    }
    
    @IBAction func tappedShowWeatherUS(_ sender: Any) {
        let cityIndex = self.citiesUSPickerView.selectedRow(inComponent: 0)
        let city = citiesUS[cityIndex]
        weather.getWeather(city: city)
        view.backgroundColor = .red
    }
    // our pickerView has one column
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    // our pickerView has citiesUS.count elements
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return citiesUS.count
    }
    
    // inform the view the current element selected
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return citiesUS[row]
    }
}
