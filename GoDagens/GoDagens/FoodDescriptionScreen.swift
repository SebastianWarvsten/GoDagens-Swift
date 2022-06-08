//
//  FoodDescription.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-24.
//

import Foundation
import UIKit
import Firebase

class FoodDescriptionScreen: UIViewController {
    
    let db = Firestore.firestore()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueTextureBackground")
        return imageView
    }()
    
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
        imageView.tintColor = .white
        return imageView
    }()
    
    private let nameTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Maträttens namn"
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = UIFont(name: textView.font!.fontName, size: 25)
        textView.textAlignment = .center
        textView.isEditable = false
        return textView
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.layer.cornerRadius = 20.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let timeTextView: UITextView = {
        let textView = UITextView()
        textView.text = "5"
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        return textView
    }()
    
    private let ingredientsTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Beskrivning om maten"
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        return textView
    }()
    
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.text = "Beskrivning om maten"
        textView.textColor = .white
        textView.backgroundColor = .clear
        textView.font = UIFont(name: textView.font!.fontName, size: 18)
        textView.isEditable = false
        return textView
    }()
    
    lazy var contentViewSize = CGSize(width: self.view.frame.width, height: self.view.frame.height + 100)
    var matArray = [FoodModel]()
    var selectedFood: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        
        view.addSubview(scroller)
        scroller.addSubview(contentView)
        
        contentView.addSubview(nameTextView)
        contentView.addSubview(updateImageView)
        contentView.addSubview(imageView)
        contentView.addSubview(timeTextView)
        contentView.addSubview(ingredientsTextView)
        contentView.addSubview(descriptionTextView)
        
        imageView.frame = CGRect(x: (view.frame.width-300)/2, y: view.safeAreaInsets.top+100, width: 300, height: 300)
        getRandomFood()
        
        updateImageView.isUserInteractionEnabled = true
        updateImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.updateTapped)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        nameTextView.frame = CGRect(x: 50, y: 0, width: view.frame.size.width-100, height: 100)
        nameTextView.centerVertically()
        updateImageView.frame = CGRect(x: view.frame.width-35, y: view.safeAreaInsets.top+10, width: 30, height: 30)
        timeTextView.frame = CGRect(x: 50, y: 400, width: view.frame.size.width-100, height: 50)
        ingredientsTextView.frame = CGRect(x: 50, y: 450, width: view.frame.size.width-100, height: 150)
        descriptionTextView.frame = CGRect(x: 50, y: 610, width: view.frame.size.width-100, height: 200)
    }
    
    @objc func updateTapped() {
        let updateSymbol = UIImage(systemName: "square.and.arrow.down")
        let editSymbol = UIImage(systemName: "square.and.pencil")
        if(updateImageView.image == editSymbol){
            // Dra ut till en funktion där symbol och textviews är argument
            updateImageView.image = updateSymbol
            nameTextView.isEditable = true
            timeTextView.isEditable = true
            descriptionTextView.isEditable = true
            nameTextView.textColor = .white
            changeBackgroundColor(textView: nameTextView, isEditing: true)
            changeBackgroundColor(textView: timeTextView, isEditing: true)
            changeBackgroundColor(textView: descriptionTextView, isEditing: true)
        }else {
            // Dra ut till en funktion där symbol och textviews är argument
            updateImageView.image = editSymbol
            nameTextView.isEditable = false
            timeTextView.isEditable = false
            descriptionTextView.isEditable = false
            nameTextView.textColor = .white
            changeBackgroundColor(textView: nameTextView, isEditing: false)
            changeBackgroundColor(textView: timeTextView, isEditing: false)
            changeBackgroundColor(textView: descriptionTextView, isEditing: false)
            updateFood()
        }
    }
    
    func updateFood() {
        let selectedID = matArray[selectedFood].id!
        let namn = nameTextView.text
        let tillagningstid: Int? = Int(timeTextView.text!.replacingOccurrences(of: " min", with: ""))
        let beskrivning = descriptionTextView.text
        
        db.collection("Food").document(selectedID).updateData([
            "Namn": namn ?? "Maträtt",
            "Tillagningstid": tillagningstid ?? 10,
            "Beskrivning": beskrivning ?? "Tillaga som vanligt"
        ]) { err in
            if let err = err {
                print("Error updating document: \(err)")
            } else {
                print("Document successfully updated")
                self.alertbox()
            }
        }
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
    
    func alertbox() {
        let alert = UIAlertController(title: "\(self.matArray[self.selectedFood].name) uppdaterad", message: "\(self.matArray[self.selectedFood].name) har blivit uppdaterad", preferredStyle: UIAlertController.Style.alert)

        
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

        self.present(alert, animated: true, completion: nil)
        
        let when = DispatchTime.now() + 3
        DispatchQueue.main.asyncAfter(deadline: when){
          // your code with delay
          alert.dismiss(animated: true, completion: nil)
        }
    }
}
