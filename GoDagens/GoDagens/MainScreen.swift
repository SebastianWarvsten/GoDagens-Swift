//
//  ViewController.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-16.
//

import UIKit
import Firebase

class MainScreen: UIViewController {

    let db = Firestore.firestore()
    
    private let backgroundImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "blueTextureBackground")
        return imageView
    }()
    
    private let textView: UITextView = {
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
        imageView.backgroundColor = .black
        imageView.layer.cornerRadius = 20.0
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let randomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemBlue
        button.setTitle("Föreslå mat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()

    var matArray = [FoodModel]()
    var randomInt = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backgroundImageView.frame = view.bounds
        view.addSubview(backgroundImageView)
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: 50, y: view.safeAreaInsets.top+200, width: view.frame.size.width-100, height: view.frame.size.width-100)
        
        view.addSubview(randomButton)
        randomButton.addTarget(self, action: #selector(getRandomFood), for: .touchUpInside)
        
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.imageTap)))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 50, y: 50, width: view.frame.size.width-100, height: 200)
        textView.centerVertically()
        
        randomButton.frame = CGRect(x: 20, y: view.frame.size.height-50-view.safeAreaInsets.bottom, width: view.frame.size.width-40, height: 50)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        updateMatArray()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! FoodDescriptionScreen
        destinationVC.matArray = self.matArray
        destinationVC.selectedFood = self.randomInt
    }
    
    @objc func imageTap() {
        performSegue(withIdentifier: "showFoodSegue", sender: self)
    }
    
    func updateMatArray() {
        self.matArray.removeAll()
        db.collection("Food").getDocuments { snapshot, err in
            if err == nil && snapshot != nil {
                
                for document in snapshot!.documents {

                    let namn = document.data()["Namn"]
                    let imageURL = document.data()["imageURL"]
                    let time = document.data()["Tillagningstid"]
                    let ingredients = document.data()["Ingredienser"]
                    let descrip = document.data()["Beskrivning"]
                    let id = document.data()["id"]
                    
                    var foodObject = FoodModel()
                    foodObject.name = namn as! String
                    foodObject.imageURL = imageURL as! String
                    foodObject.time = time as! Int
                    foodObject.ingrediets = ingredients as! [String]
                    foodObject.descrip = descrip as! String
                    foodObject.id = id as? String
                    self.matArray.append(foodObject)
                }
                if self.imageView.image == nil {
                    self.getRandomFood()
                }
            }
        }
    }
    
    @objc func getRandomFood() {
        randomInt = Int.random(in: 0...self.matArray.count-1)
        self.textView.text = self.matArray[randomInt].name
        let url = URL(string: self.matArray[randomInt].imageURL)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        self.imageView.image = UIImage(data: data)
    }
}

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
