//
//  DollarViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 27/01/23.
//

import UIKit

class DollarViewController: UIViewController, DollarModelDelegate {
    
    //MARK: -Outlets
    @IBOutlet weak var euroText: UITextField!
    
    @IBOutlet weak var dollarArea: UITextField!
    
    @IBOutlet weak var dollarButton: UIButton!
    
    //MARK: -Property
    //an instance of DollarModel
    let dollarRate = DollarModel()
    
    //MARK: -Override
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dollarRate.delegate = self
        
        //white and black mode
        dollarArea.textColor = UIColor.black
        euroText.textColor = UIColor.black
        if #available(iOS 13.0, *) {
            euroText.textColor = UIColor.label
            dollarArea.textColor = UIColor.label
        }
    }
    
    // MARK: - DollarModelDelegate
    
    func didReceiveError(_ error: APIError) {
        print("\(error)")
        // Display error here
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
    
    func didReceiveDollarValue(_ value: Double) {
        // Display dollar value here
        calculate(value: value)
        print("\(value) ")
    }
    
    //MARK: -Action
    
    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        euroText.resignFirstResponder()
        dollarArea.resignFirstResponder()
    }
    
    
    @IBAction func dollarTapped(_ sender: Any) {
        euroText.resignFirstResponder()
        
        self.dollarRate.getRates()
        
    }
    
    //MARK: - Privates
    //function to calculate the amount
    private func calculate (value : Double) {
        guard let baseCurrentText = euroText.text else {
            return
        }
        guard let baseCurrencyDouble = Double(baseCurrentText) else {
            self.displayAlert(title: "Oups, Error!", message: "Please enter numbers.", preferredStyle: .alert)
            return
        }
        let result = value * baseCurrencyDouble
        dollarArea.text = String(result) + "$"
    }
    
    private func baseCurrencyTextFieldShouldReturn(_ textField: UITextField) -> Bool {
        euroText.resignFirstResponder()
        return true
    }
    
}
