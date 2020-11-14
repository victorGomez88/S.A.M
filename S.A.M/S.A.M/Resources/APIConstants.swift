//
//  APIConstants.swift
//  S.A.M
//
//  Created by Victor Gomez on 14/11/2020.
//  Copyright © 2020 Victor Gomez. All rights reserved.
//

import Foundation

class APIConstants {
    
    static let publicKey = "8c67eb812968c804892886a11a6ce07c"
    static let privateKey = "5458c4e6a9cc00c6b0b89eef0a09930cc2d01db8"
    
    static let apiKey = "&apikey=" + publicKey
    
    struct URLs {
        static let marvelDev = "https://gateway.marvel.com/v1/public/"
        static let imagesURL = ""
    }
    
    struct Endpoints {
        
        //MARK: - Characters Endpoints
        struct Characters {
            static let charactersList = "characters" //Fetches lists of characters.
            static let character = charactersList + "/%@" //Fetches a single character by id.
            static let characterComicsList = charactersList + "/%@/comics" //Fetches lists of comics fitered by a character id.
            static let characterEventsList = charactersList + "/%@/events" //Fetches lists of events fitered by a character id.
            static let characterSeriesList = charactersList + "/%@/series" //Fetches lists of series fitered by a character id.
            static let characterStoriesList = charactersList + "/%@/stories" //Fetches lists of stories fitered by a character id.
        }
        
        
        //MARK: - Comics Endpoints
        struct Comics {
            static let comicsList = "comics" //Fetches lists of comics.
            static let comic = comicsList + "/%@" //Fetches a single comic by id.
            static let comicCharactersList = comicsList + "/%@/characters" //Fetches lists of characters fitered by a comic id.
            static let comicCreatorsList = comicsList + "/%@/creators"  //Fetches lists of creators fitered by a comic id.
            static let comicEventsList = comicsList + "/%@/events" //Fetches lists of events fitered by a comic id.
            static let comicStoriesList = comicsList + "/%@/stories" //Fetches lists of stories fitered by a comic id.
        }
        
        
        //MARK: - Creators Endpoints
        struct Creators {
            static let creatorsList = "creators" //Fetches lists of creators.
            static let creator = creatorsList + "/%@" //Fetches a single creator by id.
            static let creatorComicsList = creatorsList + "/%@/comics" //Fetches lists of comics fitered by a creator id.
            static let creatorEventsList = creatorsList + "/%@/events"  //Fetches lists of events fitered by a creator id.
            static let creatorSeriesList = creatorsList + "/%@/series" //Fetches lists of series fitered by a creator id.
            static let creatorStoriesList = creatorsList + "/%@/stories" //Fetches lists of stories fitered by a creator id.
        }
        
        
        //MARK: - Events Endpoints
        struct Events {
            static let eventsList = "events" //Fetches lists of events.
            static let event = eventsList + "/%@" //Fetches a single event by id.
            static let eventCharactersList = eventsList + "/%@/characters" //Fetches lists of characters fitered by an event id.
            static let eventComicsList = eventsList + "/%@/comics" //Fetches lists of comics fitered by an event id.
            static let eventCreatorsList = eventsList + "/%@/creators"  //Fetches lists of creators fitered by an event id.
            static let eventSeriesList = eventsList + "/%@/series" //Fetches lists of series fitered by an event id.
            static let eventStoriesList = eventsList + "/%@/stories" //Fetches lists of stories fitered by an event id.
        }
        
        
        //MARK: - Series Endpoints
        struct Series {
            static let seriesList = "series" //Fetches lists of series.
            static let serie = seriesList + "/%@" //Fetches a single serie by id.
            static let serieCharactersList = seriesList + "/%@/characters" //Fetches lists of characters fitered by an serie id.
            static let serieComicsList = seriesList + "/%@/comics" //Fetches lists of comics fitered by an serie id.
            static let serieCreatorsList = seriesList + "/%@/creators"  //Fetches lists of creators fitered by an serie id.
            static let serieEventsList = seriesList + "/%@/events" //Fetches lists of events fitered by an serie id.
            static let serieStoriesList = seriesList + "/%@/stories" //Fetches lists of stories fitered by an serie id.
        }
        
        //MARK: - Stories Endpoints
        struct Stories {
            static let storiesList = "stories" //Fetches lists of stories.
            static let story = storiesList + "/%@" //Fetches a single story by id.
            static let storyCharactersList = storiesList + "/%@/characters" //Fetches lists of characters fitered by an story id.
            static let storyComicsList = storiesList + "/%@/comics" //Fetches lists of comics fitered by an story id.
            static let storyCreatorsList = storiesList + "/%@/creators"  //Fetches lists of creators fitered by an story id.
            static let storyEventsList = storiesList + "/%@/events" //Fetches lists of events fitered by an story id.
            static let storySeriesList = storiesList + "/%@/series" //Fetches lists of series fitered by an story id.
        }
    }
}
