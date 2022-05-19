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
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Matens namn"
        textField.borderStyle = .line
        return textField
    }()
    
    private let imageURLTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "https://image.com"
        textField.borderStyle = .line
        return textField
    }()
    
    private let descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.layer.borderWidth = 1
        return textField
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lägg till maträtt", for: .normal)
        button.backgroundColor = .cyan
        button.setTitleColor(.black, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
            let namn = nameTextField.text ?? "Maträtt"
            let beskrivning = descriptionTextField.text ?? "Laga i stekpannan osv"
            let imageURL = imageURLTextField.text ?? "https://source.unsplash.com/random/300x300"
            db.collection("Food").addDocument(data: ["Namn": namn, "Beskrivning": beskrivning, "Tillagningstid": 10, "imageURL": imageURL, "Ingredienser": ["Hamburgekött", "Ost", "Tomat", "Sallad", "Rödlök", "Saltgurka", "Dressing", "Hamburgebröd"]])
        }
}
