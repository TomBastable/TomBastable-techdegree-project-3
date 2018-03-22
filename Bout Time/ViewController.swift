//
//  ViewController.swift
//  Bout Time
//
//  Created by Tom Bastable on 20/03/2018.
//  Copyright © 2018 Tom Bastable. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    ///----///CONSTANTS AND VARIABLES///----///
    
    //IBOutlets
                            //Event Labels
    @IBOutlet weak var eventOneLabel: UILabel!
    @IBOutlet weak var eventTwoLabel: UILabel!
    @IBOutlet weak var eventThreeLabel: UILabel!
    @IBOutlet weak var eventFourLabel: UILabel!
                            //Event Movement Buttons
    @IBOutlet weak var eventOneDown: UIButton!
    @IBOutlet weak var eventTwoUp: UIButton!
    @IBOutlet weak var eventTwoDown: UIButton!
    @IBOutlet weak var eventThreeUp: UIButton!
    @IBOutlet weak var eventThreeDown: UIButton!
    @IBOutlet weak var eventFourUp: UIButton!
                            //Timer Label
    @IBOutlet weak var timerLabel: UILabel!
    
    
    //Game management
    var eventManager = EventManager()
    var gameManager = GameManagement()
    
    //Timer
    let totalTime = 60
    var seconds = 0 //The max ammount of time per question
    var timer = Timer()
    
    //Sounds
    
    //Events
    var eventOne: HistoricalEvent?
    var eventTwo: HistoricalEvent?
    var eventThree: HistoricalEvent?
    var eventFour: HistoricalEvent?
    
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
    }
    
    //This function should be called at the beginning of every new game eg: Initialisation and after completion of a game.
    func startNewRound(){
        //Start the timer
        runTimer()
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
    }
    
    ///This function should be called to update the eventsLabels after events have been moved or refreshed
    func refreshEventsUI(){
        eventOneLabel.text = eventOne?.eventDescription
        eventTwoLabel.text = eventTwo?.eventDescription
        eventThreeLabel.text = eventThree?.eventDescription
        eventFourLabel.text = eventFour?.eventDescription
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
            if let eventOne = eventOne, let eventTwo = eventTwo, let eventThree = eventThree, let eventFour = eventFour {
                if orderOfEventsAreCorrect(eventOne: eventOne, eventTwo: eventTwo, eventThree: eventThree, eventFour: eventFour) {
                    //Order is correct! Award the user a point and end the round.
                    gameManager.incrementScore()
                    print("correct order")
                    endCurrentRound(withCorrectOrder: true)
                }
                else{
                    //Order is incorrect, end round without awarding a point
                    print("incorrect order")
                    endCurrentRound(withCorrectOrder: false)
                }
            }
        }
    }
    
    //========//End current round//========//
    
    func endCurrentRound(withCorrectOrder correctOrder: Bool){
        timer.invalidate()
        
        if correctOrder{
            gameManager.incrementScore()
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
            timer.invalidate()
            seconds = totalTime
            timeRanOut()
        } else{
            //if the timer isn't at 0, keep updating the label!
            timerLabel.text = "0:\(seconds)"
        }
    }
    
   func timeRanOut() {
    
    }
    
    
    //======//MEMORY WARNING//======//
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

