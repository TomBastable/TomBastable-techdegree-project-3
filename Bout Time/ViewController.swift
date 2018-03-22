//
//  ViewController.swift
//  Bout Time
//
//  Created by Tom Bastable on 20/03/2018.
//  Copyright © 2018 Tom Bastable. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    //IBOutlets
    @IBOutlet weak var eventOneLabel: UILabel!
    @IBOutlet weak var eventTwoLabel: UILabel!
    @IBOutlet weak var eventThreeLabel: UILabel!
    @IBOutlet weak var eventFourLabel: UILabel!
    
    //Game management
    var eventManager = EventManager()
    var gameManager = GameManagement()
    
    //Timer
    
    //Sounds
    
    //Events
    var eventOne: HistoricalEvent?
    var eventTwo: HistoricalEvent?
    var eventThree: HistoricalEvent?
    var eventFour: HistoricalEvent?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //As this will be initial setup, populate events in code and on-screen
        getFreshEvents()
    }
    
    func getFreshEvents(){
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

