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
    
    
    @IBOutlet weak var dollarArea: UILabel!
    
    @IBOutlet weak var dollarButton: UIButton!
    
    //MARK: -Property
    
    let dollarRate = DollarModel()
    
    //MARK: -Override
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.dollarRate.delegate = self
    }
    
    // MARK: - DollarModelDelegate
    
    func didReceiveError(_ error: APIError) {
        print("\(error)")
        // Display error here
        self.displayAlert(title: error, message: "Please enter numbers.", preferredStyle: .alert)
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
    
    private func calculate (value : Double) {
        guard let baseCurrentText = euroText.text else {
            return
        }
        guard let baseCurrencyDouble = Double(baseCurrentText) else {
            self.displayAlert(title: .url, message: "Please enter numbers.", preferredStyle: .alert)
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
