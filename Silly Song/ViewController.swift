//
//  ViewController.swift
//  Silly Song
//
//  Created by Cinfwat Dogak on 07/10/2017.
//  Copyright © 2017 Dogak Cinfwat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
        lyricsView.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        if !nameField.text!.isEmpty {
            lyricsView.text = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullName: nameField.text!)
        } else {
            lyricsView.text = "Please enter your name to generate silly song."
        }
    }
}

// MARK: - UITextFieldDelegate
extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

// Returns lowercase version of the provided name where all the consonants before the first vowel have been removed.
func shortNameFromName(name: String) -> String {
    let lowercaseName = name.lowercased()
    let vowels = CharacterSet(charactersIn: "aeiou")
    
    if let range = lowercaseName.rangeOfCharacter(from: vowels) {
        return String(lowercaseName[range.lowerBound...])
    }
    
    return lowercaseName
}

// Returns the silly song lyrics with all placeholder text replaced.
func lyricsForName(lyricsTemplate: String, fullName: String) -> String {
    let shortName = shortNameFromName(name: fullName)
    
    let sillyLyrics = lyricsTemplate
        .replacingOccurrences(of: "<FULL_NAME>", with: fullName)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return sillyLyrics
}

// Silly song template.
let bananaFanaTemplate = [
    "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
    "Banana Fana Fo F<SHORT_NAME>",
    "Me My Mo M<SHORT_NAME>",
    "<FULL_NAME>"].joined(separator: "\n")

