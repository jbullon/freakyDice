//
//  ViewController.swift
//  Freaky Dice
//
//  Created by Jacob Bullon on 12/12/17.
//  Copyright © 2017 Jacob Bullon. All rights reserved.
//

// HEADER FILES
import UIKit
import AVFoundation

// VIEW CONTROLLER
class ViewController: UIViewController {
    var randomDiceIndex1 : Int = 0
    var randomDiceIndex2 : Int = 0
    var randomDiceIndex3 : Int = 0
    var randomDiceIndex4 : Int = 0
    var randomMultiplier : Int = 0
    var totalScore1 : Int = 0
    var totalScore2 : Int = 0
    var audioPlayer = AVAudioPlayer()
    var backgroundAudio = AVAudioPlayer(contentsOfURL:NSURL(fileURLWithPath: Bundle.main.path(forResource: "gameMuzik", ofType:"mp3")!), error:nil)
    // CONSTANTS
    let diceArray = ["dice1","dice2","dice3","dice4","dice5","dice6"]
    let multArray = ["add","sub","div","mult"]

    // OUTLETS
    @IBOutlet weak var diceImageView1: UIImageView!
    @IBOutlet weak var diceImageView2: UIImageView!
    @IBOutlet weak var diceImageView3: UIImageView!
    @IBOutlet weak var diceImageView4: UIImageView!
    @IBOutlet weak var multImageView1: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // roll button pressed, update images and play sound
    @IBAction func rollButtonPressed(_ sender: UIButton) {
        updateDiceImages()
        rollSound()
    }
    
    // get images of the dice based on RNG
    func updateDiceImages() {
        let when = DispatchTime.now() + 0.3
        DispatchQueue.main.asyncAfter(deadline: when) {
        self.randomDiceIndex1 = Int(arc4random_uniform(6))
        self.randomDiceIndex2 = Int(arc4random_uniform(6))
        self.randomDiceIndex3 = Int(arc4random_uniform(6))
        self.randomDiceIndex4 = Int(arc4random_uniform(6))
        self.randomMultiplier = Int(arc4random_uniform(4))
        
        // determine the operator dice at random
        if self.randomMultiplier == 0 {
            self.addDice()
        }
        if self.randomMultiplier == 1 {
            self.subDice()
        }
        if self.randomMultiplier == 2 {
            self.divDice()
        }
        if self.randomMultiplier == 3 {
            self.multDice()
        }
        
            
        // when button is pressed, image changes to random dice index
        self.diceImageView1.image = UIImage(named: self.diceArray[self.randomDiceIndex1])
        
        self.diceImageView2.image = UIImage(named: self.diceArray[self.randomDiceIndex2])
        
        self.diceImageView3.image = UIImage(named: self.diceArray[self.randomDiceIndex3])
        
        self.diceImageView4.image = UIImage(named: self.diceArray[self.randomDiceIndex4])
        
        self.multImageView1.image = UIImage(named: self.multArray[self.randomMultiplier])
    }
    }
    
    // called if a (+) is rolled
    func addDice() {
            totalScore1 = (randomDiceIndex1 + 1) + (randomDiceIndex2 + 1)
            totalScore2 = (randomDiceIndex3 + 1) + (randomDiceIndex4 + 1)
        if totalScore1 > totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You lose!")
        }
        if totalScore1 < totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You win!")
            print("100 tickets awarded!")
        }
        if totalScore1 == totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). It's a draw.")
        }
    }
    
    // called if a (-) is rolled
    func subDice() {
            totalScore1 = (randomDiceIndex1 + 1) - (randomDiceIndex2 + 1)
            if totalScore1 < 0 {
                totalScore1 = 0
            }
            totalScore2 = (randomDiceIndex3 + 1) - (randomDiceIndex4 + 1)
            if totalScore2 < 0 {
                totalScore2 = 0
            }
        if totalScore1 > totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You lose!")
        }
        if totalScore1 < totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You win!")
        }
        if totalScore1 == totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). It's a draw.")
        }
    }
    
    // called if a (/) is rolled
    func divDice() {
            totalScore1 = (randomDiceIndex1 + 1) / (randomDiceIndex2 + 1)
            totalScore2 = (randomDiceIndex3 + 1) / (randomDiceIndex4 + 1)
        if totalScore1 > totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You lose!")
        }
        if totalScore1 < totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You win!")
        }
        if totalScore1 == totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). It's a draw.")
        }
    }
    
    // called if a (x) is rolled
    func multDice() {
            totalScore1 = (randomDiceIndex1 + 1) * (randomDiceIndex2 + 1)
            totalScore2 = (randomDiceIndex3 + 1) * (randomDiceIndex4 + 1)
        if totalScore1 > totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You lose!")
        }
        if totalScore1 < totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). You win!")
        }
        if totalScore1 == totalScore2 {
            print("Your opponent's score was \(totalScore1), your score was \(totalScore2). It's a draw.")
        }
    }
    
    // play the sound for rolling the dice
    func rollSound() {
        // Set the sound file name & extension
        let when = DispatchTime.now() + 0.2
        DispatchQueue.main.asyncAfter(deadline: when) {
        let alertSound = URL(fileURLWithPath: Bundle.main.path(forResource: "diceRoll", ofType: "mp3")!)
        
        do {
            // Preparation
            try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryPlayback)
        } catch _ {
        }
        do {
            try AVAudioSession.sharedInstance().setActive(true)
        } catch _ {
        }
        
        // Play the sound
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: alertSound)
        } catch _{
        }
        
        self.audioPlayer.prepareToPlay()
        self.audioPlayer.play()
        }
    }
    
    // Play background music
}



//---CREDITS------------------------------------------------------------
// - Sound effects obtained from https://www.zapsplat.com
//---CURRENT PROBLEMS---------------------------------------------------
// - constraints look like shit on larger devices and severely clip on smaller devices
// - cast the totalScore for the division function to a float so you get an accurate score
// -
//
