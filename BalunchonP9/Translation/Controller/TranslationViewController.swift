//
//  TranslationViewController.swift
//  BalunchonP9
//
//  Created by Mikungu Giresse on 27/01/23.
//

import UIKit

class TranslationViewController: UIViewController, TranslationModelDelegate {

    //MARK: -Outlets
    
    @IBOutlet weak var textSourceArea: UITextView!
    
    @IBOutlet weak var transletedArea: UITextView!
    
    @IBOutlet weak var translateButton: UIButton!
    
    //MARK: -Property
    let translate = TranslationModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.translate.delegate = self
        
        textSourceArea.textColor = UIColor.black
        transletedArea.textColor = UIColor.black
        if #available(iOS 13.0, *) {
            textSourceArea.textColor = UIColor.label
            transletedArea.textColor = UIColor.label
        }
    }
    //MARK: - TranslationModelDelagate
    func didTranslation(_ valueFR: String) {
            print (" \(valueFR) ")
        transletedArea.text = valueFR
    }
    
    func didShowError(_ error: APIError) {
        print ("\(error)")
        switch error {
        case .url:
            self.displayAlert(title: "Oups, Error!", message: "Translation failed, There is a problem with url, Please try later !", preferredStyle: .alert)
        case .invalidData:
            self.displayAlert(title: "Oups, Error!", message: "Translation failed, The Data is invalid, Please try later !", preferredStyle: .alert)
        case .responseCode:
            self.displayAlert(title: "Oups, Error!", message: "Translation failed, There is a problem with a responseCode, Please try later !", preferredStyle: .alert)
        case .parsing:
            self.displayAlert(title: "Oups, Error!", message: "Translation failed, There is a problem with convertion's data, Please try later !", preferredStyle: .alert)
        default:
            break
        }
    }
    //MARK: -Actions

    @IBAction func translateTapped(_ sender: Any) {
        
        let encodedString = textSourceArea.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "<>!*();^:@&=+$,|/?%#[]{}~’\" ").inverted)
        translate.getTranslation(sentence: encodedString!)
    }

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textSourceArea.resignFirstResponder()
        transletedArea.resignFirstResponder()
    }
    
}
