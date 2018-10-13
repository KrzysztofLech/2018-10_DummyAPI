//
//  Alerts.swift
//  Espeo
//
//  Created by Krzysztof Lech on 13/10/2018.
//  Copyright © 2018 Krzysztof Lech. All rights reserved.
//

import UIKit

// no buttons allert
func alertWithNoButton(title: String?, message: String?) {
    guard let controller = UIApplication.getPresentedViewController() else { return }
    
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    controller.present(ac, animated: true) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            controller.dismiss(animated: true, completion: nil)
        })
    }
}

// one button alert
func alertWithOneButton(title: String?, message: String?, buttonTitle: String, buttonStyle: UIAlertAction.Style, completion: @escaping (UIAlertAction)->()) {
    guard let controller = UIApplication.getPresentedViewController() else { return }
    
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    let buttonOneAction = UIAlertAction(title: buttonTitle, style: buttonStyle, handler: completion)
    ac.addAction(buttonOneAction)
    
    controller.present(ac, animated: true)
}

// one button & cancel alert
func alertWithOneButtonAndCancel(title: String?, message: String?, buttonTitle: String, buttonStyle: UIAlertAction.Style, completion: @escaping (UIAlertAction)->()) {
    guard let controller = UIApplication.getPresentedViewController() else { return }
    
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let buttonOneAction = UIAlertAction(title: buttonTitle, style: buttonStyle, handler: completion)
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    
    ac.addAction(buttonOneAction)
    ac.addAction(cancelAction)
    controller.present(ac, animated: true)
}

// two buttons alert
func alertWithTwoButtons(title: String?, message: String?, leftButtonTitle: String, rightButtonTitle: String, leftButtonCompletion: @escaping (UIAlertAction)->(), rightButtonCompletion: @escaping (UIAlertAction)->()) {
    guard let controller = UIApplication.getPresentedViewController() else { return }
    
    let ac = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    let leftButtonAction = UIAlertAction(title: leftButtonTitle, style: .default, handler: leftButtonCompletion)
    let rightButtonAction = UIAlertAction(title: rightButtonTitle, style: .default, handler: rightButtonCompletion)
    
    ac.addAction(leftButtonAction)
    ac.addAction(rightButtonAction)
    controller.present(ac, animated: true)
}

// No Internet alert
func internetNotAvailableAlert(withCompletion completion: @escaping (UIAlertAction)->()) {
    guard let controller = UIApplication.getPresentedViewController() else { return }
    
    let ac = UIAlertController(title: "Internet is not available!", message: nil, preferredStyle: .alert)
    let buttonOneAction = UIAlertAction(title: "Try again", style: .default, handler: completion)
    ac.addAction(buttonOneAction)
    
    controller.present(ac, animated: true)
}
