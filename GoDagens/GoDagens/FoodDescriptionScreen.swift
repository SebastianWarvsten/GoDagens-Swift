//
//  FoodDescription.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-24.
//

import Foundation
import UIKit

class FoodDescriptionScreen: UIViewController {
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Maträttens namn"
        textView.textColor = .black
        textView.font = UIFont(name: textView.font!.fontName, size: 25)
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let timeTextView: UITextView = {
        let textView = UITextView()
        textView.text = "5"
        textView.textColor = .black
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        return textView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Beskrivning om maten"
        textView.textColor = .black
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        return textView
    }()
    
    private let ingredientsTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Beskrivning om maten"
        textView.textColor = .black
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        return textView
    }()

    var matArray = [FoodModel]()
    var selectedFood: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(nameTextView)
        view.addSubview(descriptionTextView)
        view.addSubview(timeTextView)
        view.addSubview(ingredientsTextView)
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: (view.frame.width-300)/2, y: view.safeAreaInsets.top+200, width: 300, height: 300)
        getRandomFood()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextView.frame = CGRect(x: 50, y: 50, width: 300, height: 200)
        nameTextView.centerVertically()
        descriptionTextView.frame = CGRect(x: 50, y: 550, width: 300, height: 200)
        timeTextView.frame = CGRect(x: 50, y: 500, width: 100, height: 50)
        ingredientsTextView.frame = CGRect(x: 50, y: 600, width: 200, height: 200)
    }
    
    @objc func getRandomFood() {
        self.nameTextView.text = self.matArray[self.selectedFood].name
        let url = URL(string: self.matArray[self.selectedFood].imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        self.imageView.image = UIImage(data: data)
        self.descriptionTextView.text = self.matArray[self.selectedFood].descrip
        self.timeTextView.text = String(self.matArray[self.selectedFood].time).appending(" min")
        self.ingredientsTextView.text = self.matArray[self.selectedFood].ingrediets.joined(separator: "\n")
    }
}
