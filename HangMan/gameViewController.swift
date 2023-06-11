//
//  gameViewController.swift
//  HangMan
//
//  Created by Nikita Kochubey on 5/28/23.
//


import UIKit

class gameViewController: UIViewController {
    
    
    @IBOutlet weak var message: UILabel!
    @IBOutlet weak var tries: UILabel!
    @IBOutlet weak var wordCompletion: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func didCheck(_ sender: Any) {
    }
    

}
