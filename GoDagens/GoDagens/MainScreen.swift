//
//  ViewController.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-16.
//

import UIKit

class MainScreen: UIViewController {

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
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .black
        return imageView
    }()
    
    private let randomButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.setTitle("Föreslå mat", for: .normal)
        button.setTitleColor(.white, for: .normal)
        return button
    }()
    
    let mat: [String] = [
        "Spaghetti och Köttfärssås",
        "Hamburgare och pommes",
        "Korv med bröd",
        "Världens längsa namn på en maträtt som ska täcka massor med yta skriver bara massa för att se hur mycket text det fyller upp med"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(textView)
        
        view.addSubview(imageView)
        imageView.frame = CGRect(x: (view.frame.width-300)/2, y: view.safeAreaInsets.top+200, width: 300, height: 300)
        
        view.addSubview(randomButton)
        randomButton.addTarget(self, action: #selector(randomizeFood), for: .touchUpInside)
        getRandomPhoto()
    }
    
    @objc func randomizeFood() {
        getRandomPhoto()
        textView.text = mat.randomElement()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        textView.frame = CGRect(x: 50, y: 50, width: 300, height: 200)
        textView.centerVertically()
        
        randomButton.frame = CGRect(x: 20, y: view.frame.size.height-50-view.safeAreaInsets.bottom, width: view.frame.size.width-40, height: 50)
    }
    
    func getRandomPhoto() {
        let urlString = "https://source.unsplash.com/random/300x300"
        let url = URL(string: urlString)!
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        imageView.image = UIImage(data: data)
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
