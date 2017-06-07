//
//  MarvelAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation

// Documentation : http://developer.marvel.com

private let _m = MarvelAPI()

open class MarvelAPI: API {
    
    open override class func session() -> MarvelAPI { return _m }
    
    var ts: String { return "\(Int(Date().timeIntervalSince1970))" }
    var hash: String { return "\(ts)\(MARVEL_CLIENT_SECRET)\(MARVEL_CLIENT_ID)".md5() }
    
    open override func start() {
        
        baseURL = "https://gateway.marvel.com/v1/public/"
        authTokenKey = "Marvel"
        authBasic = [
            
            "apikey" : MARVEL_CLIENT_ID,
            "ts" : ts,
            "hash" : hash
            
        ]
        
    }
    
    public enum Endpoints: String {
        
        // Characters
        
        /// Fetches List of Characters
        case characters
        /// Fetches a single character by :character_id
        case characterId
        /// Fetches lists of comics filtered by a :character_id
        case characterIdComics
        /// Fetches lists of events filtered by a :character_id
        case characterIdEvents
        /// Fetches lists of series filtered by a :character_id
        case characterIdSeries
        /// Fetches lists of stories filtered by a :character_id
        case characterIdStories
        
        // Comics
        
        /// Fetches lists of comics
        case comics
        /// Fetches a single comic by :comic_id
        case comicId
        /// Fetches lists of characters filtered by a :comic_id
        case comicIdCharacters
        /// Fetches lists of creators filtered by a :comic_id
        case comicIdCreators
        /// Fetches lists of events filtered by a :comic_id
        case comicIdEvents
        /// Fetches lists of stories filtered by a :comic_id
        case comicIdStories
        
        // Creators
        
        /// Fetches lists of creators
        case creators
        /// Fetches a single creator by :creator_id
        case creatorId
        /// Fetches lists of comics filtered by a :creator_id
        case creatorIdComics
        /// Fetches lists of events filtered by a :creator_id
        case creatorIdEvents
        /// Fetches lists of series filtered by a :creator_id
        case creatorIdSeries
        /// Fetches lists of stories filtered by a :creator_id
        case creatorIdStories
        
        // Events
        
        /// Fetches lists of events
        case events
        /// Fetches a single event by :event_id
        case eventId
        /// Fetches lists of characters filtered by an :event_id
        case eventIdCharacters
        /// Fetches lists of comics filtered by an :event_id
        case eventIdComics
        /// Fetches lists of creators filtered by an :event_id
        case eventIdCreators
        /// Fetches lists of series filtered by an :event_id
        case eventIdSeries
        /// Fetches lists of stories filtered by an :event_id
        case eventIdStories
        
        // Series
        
        /// Fetches lists of series
        case series
        /// Fetches a single comic series by :series_id
        case seriesId
        /// Fetches lists of characters filtered by a :series_id
        case seriesIdCharacters
        /// Fetches lists of comics filtered by a :series_id
        case seriesIdComics
        /// Fetches lists of creators filtered by a :series_id
        case seriesIdCreators
        /// Fetches lists of events filtered by a :series_id
        case seriesIdEvents
        /// Fetches lists of stories filtered by a :series_id
        case seriesIdStories
        
        // Stories
        
        /// Fetches lists of stories
        case stories
        /// Fetches a single comic story by :story_id
        case storyId
        /// Fetches lists of characters filtered by a :story_id
        case storyIdCharacters
        /// Fetches lists of comics filtered by a :story_id
        case storyIdComics
        /// Fetches lists of creators filtered by a :story_id
        case storyIdCreators
        /// Fetches lists of events filtered by a :story_id
        case storyIdEvents
        /// Fetches lists of series filtered by a :story_id
        case storyIdSeries
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Characters
                
                .characters : Endpoint(path: "characters"),
                .characterId : Endpoint(path: "characters/:character_id"),
                .characterIdComics : Endpoint(path: "characters/:character_id/comics"),
                .characterIdEvents : Endpoint(path: "characters/:character_id/events"),
                .characterIdSeries : Endpoint(path: "characters/:character_id/series"),
                .characterIdStories : Endpoint(path: "characters/:character_id/stories"),
            
                // Comics
                
                .comics : Endpoint(path: "comics"),
                .comicId : Endpoint(path: "comics/:comic_id"),
                .comicIdCharacters : Endpoint(path: "comics/:comic_id/characters"),
                .comicIdCreators : Endpoint(path: "comics/:comic_id/creators"),
                .comicIdEvents : Endpoint(path: "comics/:comic_id/events"),
                .comicIdStories : Endpoint(path: "comics/:comic_id/stories"),
            
                
                // Creators
                
                .creators : Endpoint(path: "creators"),
                .creatorId : Endpoint(path: "creators/:creator_id"),
                .creatorIdComics : Endpoint(path: "creators/:creator_id/comics"),
                .creatorIdEvents : Endpoint(path: "creators/:creator_id/events"),
                .creatorIdSeries : Endpoint(path: "creators/:creator_id/series"),
                .creatorIdStories : Endpoint(path: "creators/:creator_id/stories"),
                
                // Events
                
                .events : Endpoint(path: "events"),
                .eventId : Endpoint(path: "events/:event_id"),
                .eventIdCharacters : Endpoint(path: "events/:event_id/characters"),
                .eventIdComics : Endpoint(path: "events/:event_id/comics"),
                .eventIdCreators : Endpoint(path: "events/:event_id/creators"),
                .eventIdSeries : Endpoint(path: "events/:event_id/series"),
                .eventIdStories : Endpoint(path: "events/:event_id/stories"),
                
                // Series
                
                .series : Endpoint(path: "series"),
                .seriesId : Endpoint(path: "series/:series_id"),
                .seriesIdCharacters : Endpoint(path: "series/:series_id/characters"),
                .seriesIdComics : Endpoint(path: "series/:series_id/comics"),
                .seriesIdCreators : Endpoint(path: "series/:series_id/creators"),
                .seriesIdEvents : Endpoint(path: "series/:series_id/events"),
                .seriesIdStories : Endpoint(path: "series/:series_id/stories"),
                
                // Stories
                
                .stories : Endpoint(path: "stories"),
                .storyId : Endpoint(path: "stories/:story_id"),
                .storyIdCharacters : Endpoint(path: "stories/:story_id/characters"),
                .storyIdComics : Endpoint(path: "stories/:story_id/comics"),
                .storyIdCreators : Endpoint(path: "stories/:story_id/creators"),
                .storyIdEvents : Endpoint(path: "stories/:story_id/events"),
                .storyIdSeries : Endpoint(path: "stories/:story_id/series")
                
            ]
            
        }
        
    }
    
}

