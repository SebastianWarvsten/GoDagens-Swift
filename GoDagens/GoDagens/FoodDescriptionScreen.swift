//
//  FoodDescription.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-24.
//

import Foundation
import UIKit

class FoodDescriptionScreen: UIViewController {
    
    private lazy var scroller: UIScrollView = {
        let scroller = UIScrollView(frame: .zero)
        scroller.frame = self.view.bounds
        scroller.contentSize = contentViewSize
        scroller.bounces = true
        return scroller
    }()

    private lazy var contentView: UIView = {
        let nview = UIView()
        nview.frame = self.view.bounds
        nview.frame.size = contentViewSize
        return nview
    }()
    
    private let updateImageView: UIImageView = {
        let imageView = UIImageView()
        let symbol = UIImage(systemName: "square.and.pencil")
        imageView.image = symbol
        return imageView
    }()
    
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
    
    private let ingredientsTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Beskrivning om maten"
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
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    var matArray = [FoodModel]()
    var selectedFood: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(scroller)
        scroller.addSubview(contentView)
        
        contentView.addSubview(nameTextView)
        contentView.addSubview(updateImageView)
        contentView.addSubview(imageView)
        contentView.addSubview(timeTextView)
        contentView.addSubview(ingredientsTextView)
        contentView.addSubview(descriptionTextView)
        
        imageView.frame = CGRect(x: (view.frame.width-300)/2, y: view.safeAreaInsets.top+200, width: 300, height: 300)
        getRandomFood()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextView.frame = CGRect(x: 50, y: 0, width: 300, height: 200)
        nameTextView.centerVertically()
        updateImageView.frame = CGRect(x: view.frame.width-35, y: view.safeAreaInsets.top+10, width: 30, height: 30)
        timeTextView.frame = CGRect(x: 50, y: 500, width: 100, height: 50)
        ingredientsTextView.frame = CGRect(x: 50, y: 550, width: 200, height: 200)
        descriptionTextView.frame = CGRect(x: 50, y: 750, width: 300, height: 200)
    }
    
    @objc func getRandomFood() {
        self.nameTextView.text = self.matArray[self.selectedFood].name
        let url = URL(string: self.matArray[self.selectedFood].imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        self.imageView.image = UIImage(data: data)
        self.timeTextView.text = String(self.matArray[self.selectedFood].time).appending(" min")
        self.ingredientsTextView.text = self.matArray[self.selectedFood].ingrediets.joined(separator: "\n")
        self.descriptionTextView.text = self.matArray[self.selectedFood].descrip
    }
}
