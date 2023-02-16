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
    }
    //MARK: - TranslationModelDelagate
    func didTranslation(_ valueFR: String) {
            print (" \(valueFR) ")
        transletedArea.text = valueFR
    }
    
    func didShowError(_ error: APIError) {
        print ("\(error)")
        self.displayAlert(title: error, message: "Translation failed, please try again !", preferredStyle: .alert)
    }

    @IBAction func translateTapped(_ sender: Any) {
        
        let encodedString = textSourceArea.text!.addingPercentEncoding(withAllowedCharacters: CharacterSet(charactersIn: "<>!*();^:@&=+$,|/?%#[]{}~’\" ").inverted)
        translate.getTranslation(sentence: encodedString!)
    }
    

    @IBAction func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        textSourceArea.resignFirstResponder()
        transletedArea.resignFirstResponder()
    }
    
}
