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
    @IBOutlet var mainView: UIView!
    
    var letterArray: [String] = []
    var wordArray: [String] = []
    
    var game = Game()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        startNewGame()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        startNewGame()
    }
    
    @IBAction func didCheck(_ sender: Any) {
        view.endEditing(true)
        let text = checkTextField(text: textField.text)
        checkUserInput(Input: text)
        print(game.wordCompletion)
        checkTries(tries: game.tries)
    }
    
    
    
    func configureWord() {
        game.chosenWord = game.chooseRandomWord()
        imageView.image = UIImage(named: "h6")
        var completion = ""
        for _ in game.chosenWord.indices {
            completion += "_"
        }
        game.wordCompletion = completion
        configureScreen()
    }
    
   private func configureScreen() {
        wordCompletion.text = refactorCompletion(completion: game.wordCompletion)
        tries.text = String(game.tries)
    }
    
    private func refactorCompletion(completion: String) -> String {
        var newCompletion = ""
        
        for char in completion {
            newCompletion += String(char) + " "
        }
        
        return newCompletion
    }
    
    private func isValid(letter: Character) -> Bool {
        game.chosenWord.contains(letter)
        }
       
    private func checkTextField(text: String?) -> String {
        guard let text = text?.lowercased() else {return ""}
        return text
    }
    
    
    
}

extension gameViewController {
    
    func startNewGame() {
        letterArray = []
        wordArray = []
        game = Game()
        configureWord()
    }
    private func checkUserInput(Input: String) {
        let userInput = checkTextField(text: textField.text)
        guard userInput != "" else {return}
        
        if userInput.count == 1 {
            if isValid(letter: Character(userInput)) && !letterArray.contains(userInput){
                mainView.backgroundColor = .green
                letterArray.append(userInput)
                message.text = "You are right!"
                game.wordCompletion = game.openLetter(completion: game.wordCompletion, word: game.chosenWord, letter: Character(userInput))
                configureScreen()
            }
            else {
                
                if letterArray.contains(userInput) {
                    mainView.backgroundColor = .blue
                    message.text = "You have used this letter already, try a different one."
                    self.textField.text = ""
                }
                else {
                    mainView.backgroundColor = .red
                    message.text = "Sorry you are incorrect, you lost your try."
                    letterArray.append(userInput)
                    let imageName = game.mistake(tries: &game.tries)
                    imageView.image = UIImage(named: imageName)
                    tries.text = "\(game.tries)"
                }
            }
        }
        else{
            if game.chosenWord == userInput {
                wordCompletion.text = userInput
                game.wordCompletion = userInput
                message.text = "YOU WIN!!!"
                mainView.backgroundColor = .green
            }
            
            else{
                if wordArray.contains(userInput) {
                    message.text = "You have used this word already, try a different one"
                    mainView.backgroundColor = .blue
                }
                
                else {
                    mainView.backgroundColor = .red
                    message.text = "Sorry you are incorrect, you lost your try."
                    wordArray.append(userInput)
                    let imageName = game.mistake(tries: &game.tries)
                    imageView.image = UIImage(named: imageName)
                    tries.text = "\(game.tries)"
                    
                }
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.mainView.backgroundColor = UIColor(named: "defaultColor")
            self.message.text = "Enter a letter or a whole word"
            self.textField.text = ""
        }
        
    }
    private func checkTries(tries: Int) {
        if tries < 1 || game.wordCompletion == game.chosenWord {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.performSegue(withIdentifier: "result", sender: nil)
            }
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? finishingViewController {
            destination.game = self.game
        }
    
    }
}

                  
