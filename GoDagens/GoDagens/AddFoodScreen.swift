//
//  AddFoodScreen.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-17.
//

import Foundation
import UIKit
import Firebase

class AddFoodScreen: UIViewController {
    
    let db = Firestore.firestore()
    let gradiantLayer = CAGradientLayer()
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Maträttens namn"
        textField.borderStyle = .line
        textField.backgroundColor = .white
        return textField
    }()
    
    private let imageURLTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "https://image.com"
        textField.borderStyle = .line
        textField.backgroundColor = .white
        return textField
    }()
    
    private let descriptionTextField: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.backgroundColor = .white
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lägg till maträtt", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gradiantLayer.frame = view.bounds
        gradiantLayer.colors = [
            UIColor.blue.cgColor,
            UIColor.green.cgColor,
            UIColor.yellow.cgColor
        ]
        view.layer.addSublayer(gradiantLayer)
        
        // Add UI
        view.addSubview(nameTextField)
        view.addSubview(imageURLTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(addButton)
        
        // Startup functionality
        addButton.addTarget(self, action: #selector(addFood), for: .touchUpInside)
        addButton.addTarget(self, action: #selector(alertbox), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField.frame = CGRect(x: 50, y: view.safeAreaInsets.top, width: view.frame.size.width-100, height: 30)
        
        imageURLTextField.frame = CGRect(x: 50, y: view.safeAreaInsets.top+40, width: view.frame.size.width-100, height: 30)
        
        descriptionTextField.frame = CGRect(x: (view.frame.width-300)/2, y: 480, width: 300, height: 280)
        
        addButton.frame = CGRect(x: 20, y: view.frame.size.height-50-view.safeAreaInsets.bottom, width: view.frame.size.width-40, height: 50)
    }
    
    // Alert Box
    @objc func alertbox() {
        let alert = UIAlertController(title: "Maträtt tillagd", message: "En maträtt har blivit tillagd till listan", preferredStyle: UIAlertController.Style.alert)

        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    // Add new collection to Firebase
        @objc func addFood() {
            let newDocument = db.collection("Food").document()
            let namn = nameTextField.text ?? "Maträtt"
            let beskrivning = descriptionTextField.text ?? "Laga i stekpannan osv"
            var imageURL: String;
            if (imageURLTextField.text != nil) && (imageURLTextField.text!.count > 0) {
                imageURL = imageURLTextField.text!
            }else{
                imageURL = "https://www.instandngs4p.eu/wp-content/themes/fox/images/placeholder.jpg"
            }
            let ingredienser = [String](["Gurka", "Tomat", "Skinka"])
            let tillagningstid = 10

            newDocument.setData(["Namn": namn, "Beskrivning": beskrivning, "Tillagningstid": tillagningstid, "imageURL": imageURL, "Ingredienser": ingredienser, "id": newDocument.documentID])
        }
}
