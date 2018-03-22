//
//  HistoryBook.swift
//  Bout Time
//
//  Created by Tom Bastable on 21/03/2018.
//  Copyright © 2018 Tom Bastable. All rights reserved.
//

import Foundation
import GameKit

///Historical event struct for creating new historical events
struct HistoricalEvent {
    
    let eventDescription: String
    let eventYear: Int
    let informationalURL: String
    
}

///Provide enums of popular F1 figures' Wiki URL's to make writing questions faster
enum PopularF1Wikis: String {
    
    case hamilton = "https://en.wikipedia.org/wiki/Lewis_Hamilton"
    case senna = "https://en.wikipedia.org/wiki/Ayrton_Senna"
    case schumacher = "https://en.wikipedia.org/wiki/Michael_Schumacher"
    case alonso = "https://en.wikipedia.org/wiki/Fernando_Alonso"
    case button = "https://en.wikipedia.org/wiki/Jenson_Button"
    case brawn = "https://en.wikipedia.org/wiki/Ross_Brawn"
    
}

///Array of historical events, can be added to by using the HistoricalEvent struct
var arrayOfHistoricalSignificance: [HistoricalEvent] = [
    
    HistoricalEvent(eventDescription: "Advertising first appears on a Formula 1 car",
                    eventYear: 1968,
                    informationalURL: "https://www.thecarexpert.co.uk/tobacco-advertising-formula-one/"),
    
    HistoricalEvent(eventDescription: "Jochen Rindt becomes the only man to win a championship posthumously",
                    eventYear: 1970,
                    informationalURL: "https://www.formula1.com/en/championship/drivers/hall-of-fame/Jochen_Rindt.html"),
    
    HistoricalEvent(eventDescription: "Mario Andretti wins six championship races in one Season",
                    eventYear: 1978,
                    informationalURL: "https://www.formula1.com/en/championship/drivers/hall-of-fame/Mario_Andretti.html"),
    
    HistoricalEvent(eventDescription: "The FIA is formed",
                    eventYear: 1904,
                    informationalURL: "https://en.wikipedia.org/wiki/Fédération_Internationale_de_l%27Automobile"),
    
    HistoricalEvent(eventDescription: "Senna is tragically killed at Imola",
                    eventYear: 1994,
                    informationalURL: "https://en.wikipedia.org/wiki/Death_of_Ayrton_Senna"),
    
    HistoricalEvent(eventDescription: "The German Grand Prix was first televised in colour",
                    eventYear: 1967,
                    informationalURL: "https://en.wikipedia.org/wiki/1967_German_Grand_Prix"),
    
    HistoricalEvent(eventDescription: "Renault produced the first turbocharged car",
                    eventYear: 1977,
                    informationalURL: "https://en.wikipedia.org/wiki/Renault_RS01"),
    
    HistoricalEvent(eventDescription: "Adelaide hosted the 500th Grand Prix",
                    eventYear: 1990,
                    informationalURL: "https://en.wikipedia.org/wiki/1990_Australian_Grand_Prix"),
    
    HistoricalEvent(eventDescription: "The practice of sharing cars was banned",
                    eventYear: 1958,
                    informationalURL: "http://en.espn.co.uk/f1/motorsport/page/2825.html"),
    
    HistoricalEvent(eventDescription: "Schumacher wins his first championship",
                    eventYear: 1994,
                    informationalURL: PopularF1Wikis.schumacher.rawValue),
    
    HistoricalEvent(eventDescription: "Schumacher wins his final championship",
                    eventYear: 2004,
                    informationalURL: PopularF1Wikis.schumacher.rawValue),
    
    HistoricalEvent(eventDescription: "Schumacher’s first race",
                    eventYear: 1991,
                    informationalURL: PopularF1Wikis.schumacher.rawValue),
    
    HistoricalEvent(eventDescription: "Schumacher’s final race",
                    eventYear: 2012,
                    informationalURL: PopularF1Wikis.schumacher.rawValue),
    
    HistoricalEvent(eventDescription: "Senna’s first race",
                    eventYear: 1984,
                    informationalURL: PopularF1Wikis.senna.rawValue),
    
    HistoricalEvent(eventDescription: "Senna’s first win",
                    eventYear: 1985,
                    informationalURL: PopularF1Wikis.senna.rawValue),
    
    HistoricalEvent(eventDescription: "Senna’s last win",
                    eventYear: 1993,
                    informationalURL: PopularF1Wikis.senna.rawValue),
    
    HistoricalEvent(eventDescription: "Senna’s first championship",
                    eventYear: 1988,
                    informationalURL: PopularF1Wikis.senna.rawValue),
    
    HistoricalEvent(eventDescription: "Hamiltons first championship",
                    eventYear: 2008,
                    informationalURL: PopularF1Wikis.hamilton.rawValue),
    
    HistoricalEvent(eventDescription: "Hamilton’s second championship",
                    eventYear: 2014,
                    informationalURL: PopularF1Wikis.hamilton.rawValue),
    
    HistoricalEvent(eventDescription: "Hamilton’s first race",
                    eventYear: 2007,
                    informationalURL: PopularF1Wikis.hamilton.rawValue),
    
    HistoricalEvent(eventDescription: "Alonso’s first race",
                    eventYear: 2001,
                    informationalURL: PopularF1Wikis.alonso.rawValue),
    
    HistoricalEvent(eventDescription: "Alonso’s first championship",
                    eventYear: 2005,
                    informationalURL: PopularF1Wikis.alonso.rawValue),
    
    HistoricalEvent(eventDescription: "Alonso’s second championship",
                    eventYear: 2006,
                    informationalURL: PopularF1Wikis.alonso.rawValue),
    
    HistoricalEvent(eventDescription: "Button’s first race",
                    eventYear: 2000,
                    informationalURL: PopularF1Wikis.button.rawValue),
    
    HistoricalEvent(eventDescription: "Button’s last race",
                    eventYear: 2017,
                    informationalURL: PopularF1Wikis.button.rawValue),
    
    HistoricalEvent(eventDescription: "Button wins his only championship",
                    eventYear: 2009,
                    informationalURL: PopularF1Wikis.button.rawValue),
    
    HistoricalEvent(eventDescription: "Ross Brawn joins Ferrari",
                    eventYear: 1997,
                    informationalURL: PopularF1Wikis.brawn.rawValue),
    
    HistoricalEvent(eventDescription: "Ross Brawn leaves Benetton",
                    eventYear: 1996,
                    informationalURL: PopularF1Wikis.brawn.rawValue),
    
    HistoricalEvent(eventDescription: "Brawn sells Brawn GP to Mercedes",
                    eventYear: 2010,
                    informationalURL: PopularF1Wikis.brawn.rawValue),
    
    HistoricalEvent(eventDescription: "Hamilton joins Mercedes AMG Petronas",
                    eventYear: 2013,
                    informationalURL: PopularF1Wikis.hamilton.rawValue)
    
    ]
