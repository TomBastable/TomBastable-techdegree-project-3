//
//  ViewController.swift
//  Bout Time
//
//  Created by Tom Bastable on 20/03/2018.
//  Copyright © 2018 Tom Bastable. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    ///----///CONSTANTS AND VARIABLES///----///
    
    //IBOutlets
                            //Event Labels
    @IBOutlet weak var eventOneLabel: UILabel!
    @IBOutlet weak var eventTwoLabel: UILabel!
    @IBOutlet weak var eventThreeLabel: UILabel!
    @IBOutlet weak var eventFourLabel: UILabel!
                            //Event views
    @IBOutlet weak var eventOneView: UIView!
    @IBOutlet weak var eventTwoView: UIView!
    @IBOutlet weak var eventThreeView: UIView!
    @IBOutlet weak var eventFourView: UIView!
                            //Event Movement Buttons
    @IBOutlet weak var eventOneDown: UIButton!
    @IBOutlet weak var eventTwoUp: UIButton!
    @IBOutlet weak var eventTwoDown: UIButton!
    @IBOutlet weak var eventThreeUp: UIButton!
    @IBOutlet weak var eventThreeDown: UIButton!
    @IBOutlet weak var eventFourUp: UIButton!
                            //Next Round / Footer Label
    @IBOutlet weak var nextRound: UIButton!
    @IBOutlet weak var footerLabel: UILabel!
                            //Timer Label
    @IBOutlet weak var timerLabel: UILabel!
                            //Play again view
    @IBOutlet weak var playAgainView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    

    
    //Game management
    var eventManager = EventManager()
    var gameManager = GameManagement()
    
    //Timer
    let totalTime = 60
    var seconds = 0
    var timer = Timer()
    
    //Sounds
    var correctSound: SystemSoundID = 0
    var incorrectSound: SystemSoundID = 0
    
    //Events
    var eventOne: HistoricalEvent?
    var eventTwo: HistoricalEvent?
    var eventThree: HistoricalEvent?
    var eventFour: HistoricalEvent?
    
    //Event buttons
    var eventButtonOne: UIButton = UIButton()
    var eventButtonTwo: UIButton = UIButton()
    var eventButtonThree: UIButton = UIButton()
    var eventButtonFour: UIButton = UIButton()
    
    var detailString: String = ""
    
    ///----///CONSTANTS AND VARIABLES END///----///
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //=====//
        
        //Set time per round
        seconds = totalTime
        // To get shake gesture
        self.becomeFirstResponder()
        //Initial setup
        startNewRound()
        loadGameStartSound()
        createEventButtons()
        enableEventMovementInteractivity(bool: true)
        
    }
    
    //This function should be called at the beginning of every new game eg: Initialisation and after completion of a game.
    func startNewRound(){
        //Start the timer
        runTimer()
        seconds = totalTime
        timerLabel.text = "0:60"
        //set nil values to current events
        eventOne = nil
        eventTwo = nil
        eventThree = nil
        eventFour = nil
        //fill each event up with a randomly selected event
        eventOne = eventManager.randomEvent()
        eventTwo = eventManager.randomEvent()
        eventThree = eventManager.randomEvent()
        eventFour = eventManager.randomEvent()
        //refresh all four events on screen
        refreshEventsUI()
        //Hide next round button
        nextRound.isHidden = true
        playAgainView.isHidden = true
        //Check if the order is already in the right order, if it is, swap event one with three
        if let eventOne = eventOne, let eventTwo = eventTwo, let eventThree = eventThree, let eventFour = eventFour {
            if orderOfEventsAreCorrect(eventOne: eventOne, eventTwo: eventTwo, eventThree: eventThree, eventFour: eventFour) {
                swap(&self.eventOne, &self.eventThree)
            }
        }
    }
    
    ///This function should be called to update the eventsLabels after events have been moved or refreshed
    func refreshEventsUI(){
        eventOneLabel.text = eventOne?.eventDescription
        eventTwoLabel.text = eventTwo?.eventDescription
        eventThreeLabel.text = eventThree?.eventDescription
        eventFourLabel.text = eventFour?.eventDescription
    }
    
    func createEventButtons() {
        eventButtonOne = UIButton(frame: eventOneLabel.frame)
        eventButtonTwo = UIButton(frame: eventTwoLabel.frame)
        eventButtonThree = UIButton(frame: eventThreeLabel.frame)
        eventButtonFour = UIButton(frame: eventFourLabel.frame)
        
        eventButtonOne.addTarget(self, action: #selector(eventDetailRequested), for: .touchUpInside)
        eventButtonTwo.addTarget(self, action: #selector(eventDetailRequested), for: .touchUpInside)
        eventButtonThree.addTarget(self, action: #selector(eventDetailRequested), for: .touchUpInside)
        eventButtonFour.addTarget(self, action: #selector(eventDetailRequested), for: .touchUpInside)
        
        //Unwrap
        self.eventOneView.addSubview(eventButtonOne)
        self.eventTwoView.addSubview(eventButtonTwo)
        self.eventThreeView.addSubview(eventButtonThree)
        self.eventFourView.addSubview(eventButtonFour)
    }
    
    @objc func eventDetailRequested(sender: UIButton!) {
        
        
        if sender == eventButtonOne {
            detailString = eventOne!.informationalURL
        }
        else if sender == eventButtonTwo{
            detailString = eventTwo!.informationalURL
        }
        else if sender == eventButtonThree{
            detailString = eventThree!.informationalURL
        }
        else if sender == eventButtonFour{
            detailString = eventFour!.informationalURL
        }
        
        print(detailString)
        
        performSegue(withIdentifier: "webKitSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "webKitSegue" {
            if let vc = segue.destination as? WebKitViewController {
                
                vc.eventUrl = detailString
            }
        }
    }

    
    @IBAction func moveEvent(_ sender: UIButton) {
        
        //Work out which button was pressed and swap the values
        if sender == eventOneDown || sender == eventTwoUp {
            swap(&eventTwo, &eventOne)
        }
        else if sender == eventTwoDown || sender == eventThreeUp {
            swap(&eventThree, &eventTwo)
        }
        else if sender == eventFourUp || sender == eventThreeDown{
            swap(&eventThree, &eventFour)
        }
        
        //Once event movement direction is determined, repopulate the events UI
        refreshEventsUI()
        
    }
    
    //========//Check order and end round//========//
    
    func endRoundAndCheckOrder(){
        
        if let eventOne = eventOne, let eventTwo = eventTwo, let eventThree = eventThree, let eventFour = eventFour {
            if orderOfEventsAreCorrect(eventOne: eventOne, eventTwo: eventTwo, eventThree: eventThree, eventFour: eventFour) {
                //Order is correct! Award the user a point and end the round.
                print(gameManager.userScore)
                print("correct order")
                endCurrentRound(withCorrectOrder: true)
                enableEventMovementInteractivity(bool: false)
                nextRound.isHidden = false
                timerLabel.isHidden = true
                nextRound.setImage(UIImage(named: "next_round_success.png"), for: .normal)
                playCorrectSound()
                if isEndOfGame() {
                    footerLabel.text = "Tap next to see final score!"
                } else{
                    footerLabel.text = "Tap Event For More Info"
                }
            }
            else{
                //Order is incorrect, end round without awarding a point
                print("incorrect order")
                endCurrentRound(withCorrectOrder: false)
                enableEventMovementInteractivity(bool: false)
                nextRound.isHidden = false
                timerLabel.isHidden = true
                nextRound.setImage(UIImage(named: "next_round_fail.png"), for: .normal)
                playIncorrectSound()
                if isEndOfGame() {
                    footerLabel.text = "Tap next to see final score!"
                } else{
                    footerLabel.text = "Tap Event For More Info"
                }
            }
        }
        
    }
    
    //=========//Check for next round or end of game//=========//
    
    func isEndOfGame() -> Bool {
        if gameManager.currentRound == gameManager.rounds {
            //End of game.
            return true
        } else{
            return false
        }
    }
    
    //=======//Next Round//=======//
    
    
    @IBAction func nextRoundOrPlayAgain(_ sender: UIButton) {
        
        if isEndOfGame() {
            print("end of game")
            //Present Play Again Button Image
            playAgainView.isHidden = false
            scoreLabel.text = "\(gameManager.userScore)/\(gameManager.rounds)"
        } else {
            startNewRound()
            nextRound.isHidden = true
            timerLabel.isHidden = false
            enableEventMovementInteractivity(bool: true)
            gameManager.nextRound()
            footerLabel.text = "Shake to complete"
        }
    }
    //=======//Play Again//=======//
    
    @IBAction func playAgain(_ sender: UIButton) {
        gameManager.currentRound = 1
        gameManager.userScore = 0
        startNewRound()
        playAgainView.isHidden = true
        timerLabel.isHidden = false
        enableEventMovementInteractivity(bool: true)
    }
    
    
    //========//Disable event movement & detail buttons//=========//
    
    //Created to stop users from moving events once a round is over
    
    func enableEventMovementInteractivity(bool: Bool){
        eventOneDown.isEnabled = bool
        eventTwoUp.isEnabled = bool
        eventTwoDown.isEnabled = bool
        eventThreeUp.isEnabled = bool
        eventThreeDown.isEnabled = bool
        eventFourUp.isEnabled = bool
    
        
        eventButtonOne.isHidden = bool
        eventButtonTwo.isHidden = bool
        eventButtonThree.isHidden = bool
        eventButtonFour.isHidden = bool
    }
    
    //========//End current round//========//
    
    //If the user has arranged events into the correct order, increment their score.
    
    func endCurrentRound(withCorrectOrder correctOrder: Bool){
        timer.invalidate()
        
        if correctOrder{
            gameManager.incrementScore()
        }
    }
    
    //========//Shake Gesture//=======//
    
    // We are willing to become first responder to get shake motion
    override var canBecomeFirstResponder: Bool {
        get {
            return true
        }
    }
    
    // Upon shaking the phone, stop the timer and check if the order is correct
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if motion == .motionShake {
            // User has finished ordering the vents, check for validity.
            
            //Only fire if the timer is running - saves from a shake being triggered
            //between rounds
            if timer.isValid {
            endRoundAndCheckOrder()
            }
        }
    }

    //========//Timer Functionality//=======//
    
    ///Function to start a timer, that calls another function every second to update the timerLabel to show the user their countdown
    func runTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1, target: self,   selector: (#selector(ViewController.updateTimer)), userInfo: nil, repeats: true)
    }
    
    ///Function that updates the seconds variable every second, while also updating the timerLabel every second. Also handles timeout.
    @objc func updateTimer() {
        seconds -= 1
        //If the timer is at 0, the user has ran out of time
        if seconds == 0 {
            timerLabel.text = "0:00"
            timer.invalidate()
            seconds = totalTime
            timeRanOut()
        } else{
            //if the timer isn't at 0, keep updating the label!
            
            //if there are less than 10 seconds, and a 0 before an int for vanity.
            if seconds < 10{
               timerLabel.text = "0:0\(seconds)"
            }
            else{
                //if there's more than ten seconds, an extra 0 isn't required.
               timerLabel.text = "0:\(seconds)"
            }
            
        }
    }
    
    //=====//Time ran out function//=====//
    
   func timeRanOut() {
        endRoundAndCheckOrder()
    }
    
    //=====//Game Sounds//=====//
    
    ///Game sound setup
    func loadGameStartSound() {
        let pathToCorrectSoundFile = Bundle.main.path(forResource: "CorrectDing", ofType: "wav")
        let correctGameURL = URL(fileURLWithPath: pathToCorrectSoundFile!)
        AudioServicesCreateSystemSoundID(correctGameURL as CFURL, &correctSound)
        
        let pathToIncorrectSoundFile = Bundle.main.path(forResource: "IncorrectBuzz", ofType: "wav")
        
        let soundIncorrectURL = URL(fileURLWithPath: pathToIncorrectSoundFile!)
        AudioServicesCreateSystemSoundID(soundIncorrectURL as CFURL, &incorrectSound)
    }

    ///Function that needs to be called when a users events aren't in the correct order
    func playIncorrectSound() {
        AudioServicesPlaySystemSound(incorrectSound)
    }
    ///Function that needs to be called when a users events are in the correct order
    func playCorrectSound() {
        AudioServicesPlaySystemSound(correctSound)
    }
    
    //======//MEMORY WARNING//======//
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

