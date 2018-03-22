//
//  GameShowHost.swift
//  Bout Time
//
//  Created by Tom Bastable on 21/03/2018.
//  Copyright © 2018 Tom Bastable. All rights reserved.
//

import Foundation
import GameKit

///Mangages all of the games events - the initialisation, mutation, randomisation and answer checking.
struct EventManager {
    
    var seriesOfEvents = arrayOfHistoricalSignificance
    
    mutating func randomEvent() -> HistoricalEvent {
        
        //Generate a random number using GameKit to ensure that the
        //questions don't appear in the same order
        let randomNumber = GKRandomSource.sharedRandom().nextInt(upperBound: seriesOfEvents.count)
        
        //If there are no events left, refill the questions for the next game.
        if seriesOfEvents.isEmpty {
            seriesOfEvents = arrayOfHistoricalSignificance
        }
        
        //Assign random event to its own constant, use the randomIndex
        // to remove that question to avoid duplication
        let event = seriesOfEvents[randomNumber]
        seriesOfEvents.remove(at: randomNumber)
        
        //Return the randomEvent that has also been removed from the array
        return event
        
    }
    
    //In the case the events haven't been fully emptied, I'm providing a manual function to refill the events
    mutating func manualEventRefill (){
        seriesOfEvents.removeAll()
        seriesOfEvents = arrayOfHistoricalSignificance
    }
}

///Manages the game side - round, current round, userscore, increment score, next round etc.
struct GameManagement {
    //Game Round Constant
    let rounds: Int = 6
    
    //User score and current round variables
    var userScore: Int = 0
    var currentRound: Int = 1
    
    //Increase the round count
    mutating func nextRound() {
        currentRound += 1
    }
    //Reset game
    mutating func newGame() {
        currentRound = 1
        userScore = 0
    }
    
    //Increase the users score
    mutating func incrementScore() {
        userScore += 1
    }
    
}
