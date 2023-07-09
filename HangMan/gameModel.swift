//
//  model.swift
//  HangMan
//
//  Created by Nikita Kochubey on 6/11/23.
//

import Foundation

class Game {
    
    var words: [String] = ["plane", "dog", "building", "ocean", "mercury", "mountain", "space", "california", "laptop", "school", "cat"]
    
    var tries: Int = 6
    
    var chosenWord: String = "moon"
    
    var wordCompletion: String = "_________"
    
    func chooseRandomWord() -> String {
        let index = Int.random(in: 0..<words.count)
        
        return words[index]
        
    }
    
    func createCompletion(chosenWord: String) -> String {
        var completion = ""
        for _ in 1...chosenWord.count {
            completion += "_"
        }
        return completion
    }
    
    func openLetter(completion: String, word: String, letter: Character) -> String {
        var new_completion = ""
        
        let index = word.firstIndex(of: letter)
        
        for i in completion.indices {
            if i == index || word[i] == letter {
                new_completion += String(letter)
            }
            else if completion[i] != "_" {
                new_completion += String(completion[i])
            }
            else {
                new_completion += "_"
            }
        }
        return new_completion
    }
    
    func mistake(tries: inout Int) -> String {
        tries -= 1
        return "h" + String(tries)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
