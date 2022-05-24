//
//  FoodDescription.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-24.
//

import Foundation

import UIKit

class FoodDescriptionScreen: UIViewController {
    
    private let textView: UITextView = {
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

    var matArray = [FoodModel]()
    var selectedFood: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(textView)
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: (view.frame.width-300)/2, y: view.safeAreaInsets.top+200, width: 300, height: 300)
        getRandomFood()

    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 50, y: 50, width: 300, height: 200)
        textView.centerVertically()
    }
    
    @objc func getRandomFood() {
        self.textView.text = self.matArray[self.selectedFood].name
        let url = URL(string: self.matArray[self.selectedFood].imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        self.imageView.image = UIImage(data: data)
    }
}
