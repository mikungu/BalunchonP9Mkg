//
//  WeathersViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 27/01/23.
//

import UIKit

class WeathersViewController: UIViewController, WeatherModelDelegate {
    
    

    //MARK: - Outlets
    
    @IBOutlet weak var NewYorkButton: UIButton!
    
    @IBOutlet weak var RomaButton: UIButton!
    
    @IBOutlet weak var temperatureNY: UILabel!
    
    @IBOutlet weak var descriptionNY: UILabel!
    
    @IBOutlet weak var imageNY: UIImageView!
    
    @IBOutlet weak var temperatureRome: UILabel!
    
    @IBOutlet weak var descriptionRome: UILabel!
    
    @IBOutlet weak var imageRome: UIImageView!
    
    //MARK: - Property
    let weather = WeatherModel()
    
    //MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.weather.delegate = self
        
        //weather.getWeather(city: "roma")
        //weather.getWeather(city: "New+York")
    }
    
    func showWeather (_ value: Weathers) {
                    print ("\(value)")
            //temperatureNY.text = "temp = \(value.id) °  humidity = \(value.main.humidity) %"
        descriptionNY.text = "\(value.weather[0].description)"
        temperatureRome.text = "temp = \(value.main.temp)"
        descriptionRome.text = "\(value.weather[0].description)"
                }
    
    func showError (_ error: APIError) {
               print ("\(error)")
           }
    
    
    @IBAction func tappedNewYork(_ sender: Any) {
        //weather.getWeather(city: "New+York")
        //weather.getWeather(city: "Rome")
    }
    
    
    @IBAction func tappedRome(_ sender: Any) {
        
    }
    
   
        
        
        
        //weather.getWeather(city: "New+York") { result in
        //    switch result {
    //   case .success(let weather):
           //     self.descriptionNY.text = weather.weather.description
          //      self.temperatureNY.text = "Ici, il fait \(weather.main) !"
          //  case .failure(let error):
           //     print (error)
          //  }
       // }
        //weather.getWeather(city: "Rome") { result in
        //    switch result {
         //   case .success(let weather):
          //      self.descriptionRome.text = weather.weather.description
         //       self.temperatureRome.text = "Ici, il fait \(weather.main) !"
         //   case .failure(let error):
         //       print (error)
         //   }
       // }
        
    }
    

