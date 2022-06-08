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
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueTextureBackground")
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.text = "Maträtt:"
        nameLabel.textColor = .white
        return nameLabel
    }()
    
    private let imageURLLabel: UILabel = {
        let imageURLLabel = UILabel()
        imageURLLabel.text = "Bild URL:"
        imageURLLabel.textColor = .white
        return imageURLLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.text = "Beskrivning:"
        descriptionLabel.textColor = .white
        return descriptionLabel
    }()
    
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
        textField.autocapitalizationType = .none
        return textField
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderWidth = 1
        textView.backgroundColor = .white
        return textView
    }()
    
    private let addButton: UIButton = {
        let button = UIButton()
        button.setTitle("Lägg till maträtt", for: .normal)
        button.isEnabled = false
        button.backgroundColor = .gray
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        
        // Add UI
        view.addSubview(nameLabel)
        view.addSubview(nameTextField)
        view.addSubview(imageURLLabel)
        view.addSubview(imageURLTextField)
        view.addSubview(descriptionLabel)
        view.addSubview(descriptionTextView)
        view.addSubview(addButton)
        
        // Startup functionality
        addButton.addTarget(self, action: #selector(addFood), for: .touchUpInside)
        nameTextField.addTarget(self, action: #selector(AddFoodScreen.textFieldDidChange(_:)),
                                  for: .editingChanged)
        imageURLTextField.addTarget(self, action: #selector(AddFoodScreen.textFieldDidChange(_:)),
                                  for: .editingChanged)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameLabel.frame = CGRect(x: 50, y: view.safeAreaInsets.top, width: view.frame.size.width-100, height: 30)
        nameTextField.frame = CGRect(x: 50, y: view.safeAreaInsets.top+30, width: view.frame.size.width-100, height: 30)
        
        imageURLLabel.frame = CGRect(x: 50, y: view.safeAreaInsets.top+70, width: view.frame.size.width-100, height: 30)
        imageURLTextField.frame = CGRect(x: 50, y: view.safeAreaInsets.top+100, width: view.frame.size.width-100, height: 30)
        
        descriptionLabel.frame = CGRect(x: 50, y: view.frame.size.height-300-view.safeAreaInsets.bottom, width: view.frame.size.width-100, height: 30)
        descriptionTextView.frame = CGRect(x: 50, y: view.frame.size.height-270-view.safeAreaInsets.bottom, width: view.frame.size.width-100, height: 200)
        
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
            let beskrivning = descriptionTextView.text ?? "Laga i stekpannan osv"
            var imageURL: String;
            if (imageURLTextField.text != nil) && (imageURLTextField.text!.count > 0) {
                imageURL = imageURLTextField.text!
            }else{
                imageURL = "https://www.instandngs4p.eu/wp-content/themes/fox/images/placeholder.jpg"
            }
            let ingredienser = [String](["Gurka", "Tomat", "Skinka"])
            let tillagningstid = 10

            newDocument.setData(["Namn": namn, "Beskrivning": beskrivning, "Tillagningstid": tillagningstid, "imageURL": imageURL, "Ingredienser": ingredienser, "id": newDocument.documentID])
            clearAllFields(name: nameTextField, imageURL: imageURLTextField, descrip: descriptionTextView)
            alertbox()
            disableButton(button: addButton)
        }
    
    func allFieldsValid() -> Bool {
        return (isNameTextFieldValid(nameTextField: nameTextField) && isImageURLValid(imageURLTextField: imageURLTextField))
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        if(allFieldsValid()){
            addButton.isEnabled = true
            addButton.backgroundColor = .blue
        } else {
            addButton.isEnabled = false
            addButton.backgroundColor = .gray
        }
    }
}
