//
//  TextFieldValidator.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-31.
//

import Foundation
import UIKit

func isNameTextFieldValid(nameTextField: UITextField) -> Bool {
    let regEx = "[a-zåäöA-ZÅÄÖ ]{2,100}"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
    return predicate.evaluate(with: nameTextField.text)
}

func isImageURLValid(imageURLTextField: UITextField) -> Bool {
    let regEx = "(http|https|file)://((/)*|(\\w)*|([0-9A-Za-z]*)|([-|_])*([\\.|/])*)+\\.(?i)(jpeg|jpg|png|gif)+(?-i)(?:([0-9A-Za-z\'.%-_?=&']*))?"
    let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
    return predicate.evaluate(with: imageURLTextField.text)
}
func changeBorderColor(textField: UITextField, textFieldIntpuIsValid: Bool) {
    if(textFieldIntpuIsValid || textField.text!.count == 0) {
        textField.layer.borderColor = UIColor.black.cgColor
        textField.layer.borderWidth = 1
    } else {
        textField.layer.borderColor = UIColor.red.cgColor
        textField.layer.borderWidth = 1
    }
}
func changeBackgroundColor(textView: UITextView, isEditing: Bool) {
    if(isEditing) {
        textView.backgroundColor = .white
    } else {
        textView.backgroundColor = .clear
    }
}

func clearAllFields(name: UITextField, imageURL: UITextField, descrip: UITextView) {
    name.text = nil
    imageURL.text = nil
    descrip.text = nil
}

func disableButton(button: UIButton) {
    if(button.isEnabled == true) {
        button.isEnabled = false
        button.backgroundColor = .gray
    } else {
        button.isEnabled = true
        button.backgroundColor = .blue
    }
}
