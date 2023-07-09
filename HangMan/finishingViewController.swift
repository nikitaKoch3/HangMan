//
//  finishingViewController.swift
//  HangMan
//
//  Created by Nikita Kochubey on 6/29/23.
//

import UIKit

class finishingViewController: UIViewController {
    @IBOutlet var screenView: UIView!
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var guessedWord: UILabel!
    
    @IBOutlet weak var tries: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    var game: Game?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        configureScreen()
    }
    
    @IBAction func didConfirm(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    @IBAction func didDismiss(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    
}

extension finishingViewController {
    private func configureScreen() {
        guard let game = game else {return}
        imageView.image = UIImage(named: "h" + String(game.tries))
        tries.text = "you have \(game.tries) tries left"
        guessedWord.text = "The guessed word is \(game.chosenWord)"
        if game.wordCompletion == game.chosenWord {
            result.text = "YOU WIN!!"
            screenView.backgroundColor = .green
        }
        else {
            result.text = "YOU LOSE =("
            screenView.backgroundColor = .red
        }
        
    }
    
}
