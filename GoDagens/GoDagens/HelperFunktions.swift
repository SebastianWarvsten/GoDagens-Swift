//
//  TextFieldValidator.swift
//  GoDagens
//
//  Created by Sebastian Warvsten on 2022-05-31.
//

import Foundation
import UIKit

/*

 #import "TextFieldValidation.h"

 @implementation TextFieldValidation

 +(BOOL)isNameValidInput:(NSString *)name {
     NSString *validRegEX = @"[a-zåäöA-ZÅÄÖ ]{1,100}";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:name];
 }

 +(BOOL)isZipcodeValidInput:(NSString *)zipcode {
     NSString *validRegEX = @"[0-9]{3,3}\\s{1,1}[0-9]{2,2}";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:zipcode];
 }

 +(BOOL)isPhonenumberValidInput:(NSString *)phonenumber {
     NSString *validRegEX = @"[0-9]{8,10}";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:phonenumber];
 }

 +(BOOL)isEmailValidInput:(NSString *)email {
     NSString *validRegEX = @"[a-zA-Z0-9._]+@[a-zA-Z0-9]+\\.[a-zA-Z]{2,5}";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:email];
 }

 +(BOOL)isPasswordValidInput:(NSString *)password {
     NSString *validRegEX = @"\\S{6,25}";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:password];
 }

 +(BOOL)isOrgnumberValidInput:(NSString *)orgnumber {
     NSString *validRegEX = @"[0-9]{10,10}";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:orgnumber];
 }

 +(BOOL)isCompanynameValidInput:(NSString *)companyname{
     NSString *validRegEX = @"(?!\\s+$)[a-zåäöA-ZÅÄÖ0-9]{1,50}+(\\s{0,1}+[a-zåäöA-ZÅÄÖ0-9]{0,50})*";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:companyname];
 }

 +(BOOL)isAddressValidInput:(NSString *)address{
     NSString *validRegEX = @"(?!\\s+$)[a-zåäöA-ZÅÄÖ0-9]{5,50}+(\\s{0,1}+[a-zåäöA-ZÅÄÖ0-9]{0,50})*";
     NSPredicate *validPost;
     validPost = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", validRegEX];
     return [validPost evaluateWithObject:address];
 }

 @end

 */

/*
 -(IBAction)nameTextFieldEdited:(id)sender {
     BOOL isNameValid = [TextFieldValidation isNameValidInput:_textfieldName.text];
     [self changeBorderColor:_textfieldName :isNameValid];
     [self enableAccountButton:_createAccountButton];
 }
 
 +(BOOL)isImageURLValid :(UITextField*)textField{
     NSString *imageURLRegEx = @"(http|https|file)://((/)*|(\\w)*|([0-9A-Za-z]*)|([-|_])*([\\.|/])*)+\\.(?i)(jpeg|jpg|png|gif)+(?-i)(?:([0-9A-Za-z\'.%-_?=&']*))?";
     NSPredicate *validURL = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", imageURLRegEx];
     return [validURL evaluateWithObject:textField.text];
 }
 
 -(BOOL)allFieldsAreValid {
     return ([TextFieldValidation isNameValidInput:_textfieldName.text] &&
             [TextFieldValidation isNameValidInput:_textfieldLastName.text] &&
             [TextFieldValidation isZipcodeValidInput:_textfieldZipCode.text] &&
             [TextFieldValidation isPhonenumberValidInput:_textfieldPhone.text] &&
             [TextFieldValidation isEmailValidInput:_textfieldEmail.text] &&
             [TextFieldValidation isPasswordValidInput:_textfieldPassword.text] &&
             [TextFieldValidation isPasswordValidInput:_textfieldRepeastPassword.text] &&
             [self.textfieldPassword.text isEqual:self.textfieldRepeastPassword.text]);
 }

 -(void)changeBorderColor:(UITextField *)textField :(BOOL)textFieldInputIsvalid {
     if(textFieldInputIsvalid || textField.text.length == 0) {
         textField.layer.borderWidth=0;
     } else {
         textField.layer.borderColor = [[UIColor redColor] CGColor];
         textField.layer.borderWidth=1.0;
     }
 }
 
 -(void)enableAccountButton:(UIButton *)button {
     if([self allFieldsAreValid]) {
         button.enabled = YES;
     } else {
         button.enabled = NO;
     }
 }
 

 */

func clearAllFields(name: UITextField, imageURL: UITextField, descrip: UITextView) {
    name.text = nil
    imageURL.text = nil
    descrip.text = nil
}

func disableButton(button: UIButton) {
    if(button.isEnabled == true){
        button.isEnabled = false
        button.backgroundColor = .gray
    } else {
        button.isEnabled = true
        button.backgroundColor = .blue
    }
}
