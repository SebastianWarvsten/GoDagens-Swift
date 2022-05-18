//
//  AddFoodScreen.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-17.
//

import Foundation
import UIKit

class AddFoodScreen: UIViewController {
    
    private let nameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Matens namn"
        textField.borderStyle = .line
        return textField
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
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
        
        view.addSubview(nameTextField)
        view.addSubview(imageView)
        view.addSubview(descriptionTextField)
        view.addSubview(addButton)
        getRandomPhoto()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextField.frame = CGRect(x: 50, y: view.safeAreaInsets.top, width: view.frame.size.width-100, height: 30)
        // center.x - size.width / 2
        imageView.frame = CGRect(x: (view.frame.width-300)/2, y: view.safeAreaInsets.top+80, width: 300, height: 300)
        
        descriptionTextField.frame = CGRect(x: (view.frame.width-300)/2, y: 480, width: 300, height: 280)
        
        addButton.frame = CGRect(x: 20, y: view.frame.size.height-50-view.safeAreaInsets.bottom, width: view.frame.size.width-40, height: 50)
    }
    
    // Ta bort getRandomPhoto när det är fixat
    func getRandomPhoto() {
        let urlString = "https://source.unsplash.com/random/300x300"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
    }
}
