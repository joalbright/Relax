//
//  FoursquareAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://developer.foursquare.com

private let _fs = FoursquareAPI()

open class FoursquareAPI: API {
    
    open override class func session() -> FoursquareAPI { return _fs }
    
    open override func start() {
        
        baseURL = "https://api.foursquare.com/v2/"
        authURL = "https://foursquare.com/oauth2/"
        authTokenKey = "Foursquare"
        authBasic = [
            
            "client_id" : FOURSQUARE_CLIENT_ID,
            "client_secret" : FOURSQUARE_CLIENT_SECRET,
            "access_token" : "ACCESS_TOKEN",
            "v" : "20160112"
            
        ]
        
    }
    
    open override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.auth.endpoint
        
        auth.parameters = [
            
            "client_id" : FOURSQUARE_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co"
            
        ]
        
        var authCode = Endpoints.authCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : FOURSQUARE_CLIENT_ID,
            "client_secret" : FOURSQUARE_CLIENT_SECRET,
            "redirect_uri" : "https://code.jo2.co",
            "grant_type" : "authorization_code"
            
        ]

        return (auth, authCode)
        
    }
    
    public enum Endpoints: String {
        
        // Auth
        
        case auth
        case authCode
        
        // Users
        
        case users
        case usersRequests
        case usersSearch
        case usersCheckins
        case usersFriends
        case usersLists
        case usersMayorships
        case usersPhotos
        case usersTastes
        case usersVenueHistory
        case usersVenueLikes
        case usersApprove
        case usersDeny
        case usersSetPings
        case usersUnfriend
        case usersUpdate
        
        // Venues
        
        /// Get venue by :venue_id
        case venues
        /// Add new venue
        case venuesAdd
        /// 
        case venuesCategories
        /// Explore suggested venues using "near" or "ll"
        case venuesExplore
        case venuesManaged
        /// Search all venues using "near" or "ll"
        case venuesSearch
        case venuesSuggestedCompletion
        case venuesTimeSeries
        case venuesTrending
        case venuesEvents
        case venuesHereNow
        case venuesHours
        case venuesLikes
        case venuesLinks
        case venuesListed
        case venuesMenu
        case venuesNextVenues
        case venuesPhotos
        case venuesSimilar
        case venuesStats
        case venuesTips
        case venuesClaim
        case venuesDislike
        case venuesFlag
        case venuesLike
        case venuesProposeEdit
        case venuesSetRole
        case venuesSetSingleLocation
        
        // Venue Groups
        
        case venueGroups
        case venueGroupsAdd
        case venueGroupsDelete
        case venueGroupsList
        case venueGroupsTimeSeries
        case venueGroupsAddVenue
        case venueGroupsEdit
        case venueGroupsRemoveVenue
        case venueGroupsUpdate
        
        // Checkins
        
        case checkins
        case checkinsAdd
        case checkinsRecent
        case checkinsResolve
        case checkinsLikes
        case checkinsAddComment
        case checkinsAddPost
        case checkinsDeleteComment
        case checkinsLike
        
        // Tips
        
        case tips
        case tipsAdd
        case tipsLikes
        case tipsListed
        case tipsSaves
        case tipsFlag
        case tipsLike
        case tipsUnmark
        
        // Lists
        
        case lists
        case listsAdd
        case listsFollowers
        case listsItems
        case listsSaves
        case listsSuggestPhoto
        case listsSuggestTip
        case listsSuggestVenues
        case listsAddItem
        case listsDeleteItem
        case listsFollow
        case listsMoveItem
        case listsShare
        case listsUnfollow
        case listsUpdate
        case listsUpdateItem
        
        // Updates
        
        case updates
        case updatesNotifications
        case updatesMarkNotificationsRead
        
        // Photos
        
        case photos
        case photosAdd
        
        // Settings
        
        case settings
        case settingsAll
        case settingsSet
        
        // Specials
        
        case specials
        case specialsAdd
        case specialsList
        case specialsSearch
        case specialsFlag
        
        // Events
        
        case events
        case eventsCategories
        case eventsSearch
        case eventsAdd
        
        // Pages
        
        case pagesAdd
        case pagesManaging
        case pagesAccess
        case pagesSimilar
        case pagesTimeSeries
        case pagesVenues
        case pagesFollow
        
        // Page Updates
        
        case pageUpdates
        case pageUpdatesAdd
        case pageUpdatesList
        case pageUpdatesDelete
        case pageUpdatesLike
        
        // Multi
        
        case multiGET
        case multiPOST
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .auth : Endpoint(path: "authenticate", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .authCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
            
                // Users
                
                .users : Endpoint(path: "users/:user_id", requiresUser: true),
                .usersRequests : Endpoint(path: "users/requests", requiresUser: true),
                .usersSearch : Endpoint(path: "users/search", requiresUser: true),
                .usersCheckins : Endpoint(path: "users/:user_id/checkins", requiresUser: true),
                .usersFriends : Endpoint(path: "users/:user_id/friends", requiresUser: true),
                .usersLists : Endpoint(path: "users/:user_id/lists", requiresUser: true),
                .usersMayorships : Endpoint(path: "users/:user_id/mayorships", requiresUser: true),
                .usersPhotos : Endpoint(path: "users/:user_id/photos", requiresUser: true),
                .usersTastes : Endpoint(path: "users/:user_id/tastes", requiresUser: true),
                .usersVenueHistory : Endpoint(path: "users/:user_id/venuehistory", requiresUser: true),
                .usersVenueLikes : Endpoint(path: "users/:user_id/venuelikes", requiresUser: true),
                .usersApprove : Endpoint(path: "users/:user_id/approve", method: .POST, requiresUser: true),
                .usersDeny : Endpoint(path: "users/:user_id/deny", method: .POST, requiresUser: true),
                .usersSetPings : Endpoint(path: "users/:user_id/setpings", method: .POST, requiredParameters: ["value"], requiresUser: true),
                .usersUnfriend : Endpoint(path: "users/:user_id/unfriend", method: .POST, requiresUser: true),
                .usersUpdate : Endpoint(path: "users/self/update", method: .POST, requiresUser: true),
                
                // Venues
                
                .venues : Endpoint(path: "venues/:venue_id"),
                .venuesAdd : Endpoint(path: "venues/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .venuesCategories : Endpoint(path: "venues/categories"),
                .venuesExplore : Endpoint(path: "venues/explore", requiredParameters: ["ll,near"]),
                .venuesManaged : Endpoint(path: "venues/managed", requiresUser: true),
                .venuesSearch : Endpoint(path: "venues/search", requiredParameters: ["ll,near"]),
                .venuesSuggestedCompletion : Endpoint(path: "venues/suggestcompletion", requiredParameters: ["ll,near","query"]),
                .venuesTimeSeries : Endpoint(path: "venues/timeseries", requiresUser: true),
                .venuesTrending : Endpoint(path: "venues/trending", requiredParameters: ["ll"]),
                .venuesEvents : Endpoint(path: "venues/:venue_id/events"),
                .venuesHereNow : Endpoint(path: "venues/:venue_id/herenow", requiresUser: true),
                .venuesHours : Endpoint(path: "venues/:venue_id/hours"),
                .venuesLikes : Endpoint(path: "venues/:venue_id/likes"),
                .venuesLinks : Endpoint(path: "venues/:venue_id/links"),
                .venuesListed : Endpoint(path: "venues/:venue_id/listed"),
                .venuesMenu : Endpoint(path: "venues/:venue_id/menu"),
                .venuesNextVenues : Endpoint(path: "venues/:venue_id/nextvenues"),
                .venuesPhotos : Endpoint(path: "venues/:venue_id/photos"),
                .venuesSimilar : Endpoint(path: "venues/:venue_id/similar", requiresUser: true),
                .venuesStats : Endpoint(path: "venues/:venue_id/stats", requiresUser: true),
                .venuesTips : Endpoint(path: "venues/:venue_id/tips"),
                .venuesClaim : Endpoint(path: "venues/:venue_id/claim", method: .POST, requiresUser: true),
                .venuesDislike : Endpoint(path: "venues/:venue_id/dislike", method: .POST, requiresUser: true),
                .venuesFlag : Endpoint(path: "venues/:venue_id/flag", method: .POST, requiredParameters: ["problem"], requiresUser: true),
                .venuesLike : Endpoint(path: "venues/:venue_id/like", method: .POST, requiresUser: true),
                .venuesProposeEdit : Endpoint(path: "venues/:venue_id/proposeedit", method: .POST, requiresUser: true),
                .venuesSetRole : Endpoint(path: "venues/:venue_id/setrole", method: .POST, requiresUser: true),
                .venuesSetSingleLocation : Endpoint(path: "venues/:venue_id/setsinglelocation", requiresUser: true),
                
                // Venue Groups
                
                .venueGroups : Endpoint(path: "venuegroups/:group_id", requiresUser: true),
                .venueGroupsAdd : Endpoint(path: "venuegroups/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .venueGroupsDelete : Endpoint(path: "venuegroups/:group_id/delete", method: .POST, requiresUser: true),
                .venueGroupsList : Endpoint(path: "venuegroups/list", requiresUser: true),
                .venueGroupsTimeSeries : Endpoint(path: "venuegroups/:group_id/timeseries", requiredParameters: ["startAt"], requiresUser: true),
                .venueGroupsAddVenue : Endpoint(path: "venuegroups/:group_id/addvenue", method: .POST, requiredParameters: ["venueId"], requiresUser: true),
                .venueGroupsEdit : Endpoint(path: "venuegroups/:group_id/edit", method: .POST, requiresUser: true),
                .venueGroupsRemoveVenue : Endpoint(path: "venuegroups/:group_id/removevenue", method: .POST, requiredParameters: ["venueId"], requiresUser: true),
                .venueGroupsUpdate : Endpoint(path: "venuegroups/:group_id/update", method: .POST, requiresUser: true),
                
                // Checkins
                
                .checkins : Endpoint(path: "checkins/:checkin_id", requiresUser: true),
                .checkinsAdd : Endpoint(path: "checkins/add", method: .POST, requiredParameters: ["venueId"], requiresUser: true),
                .checkinsRecent : Endpoint(path: "checkins/recent", requiresUser: true),
                .checkinsResolve : Endpoint(path: "checkins/resolve", requiredParameters: ["shortId"], requiresUser: true),
                .checkinsLikes : Endpoint(path: "checkins/:checkin_id/likes"),
                .checkinsAddComment : Endpoint(path: "checkins/:checkin_id/addcomment", method: .POST, requiresUser: true),
                .checkinsAddPost : Endpoint(path: "checkins/:checkin_id/addpost", method: .POST, requiresUser: true),
                .checkinsDeleteComment : Endpoint(path: "checkins/:checkin_id/deletecomment", method: .POST, requiresUser: true),
                .checkinsLike : Endpoint(path: "checkins/:checkin_id/like", method: .POST, requiresUser: true),

                // Tips
                
                .tips : Endpoint(path: "tips/:tip_id"),
                .tipsAdd : Endpoint(path: "tips/add", method: .POST, requiredParameters: ["venueId","text"], requiresUser: true),
                .tipsLikes : Endpoint(path: "tips/:tip_id/likes"),
                .tipsListed : Endpoint(path: "tips/:tip_id/listed"),
                .tipsSaves : Endpoint(path: "tips/:tip_id/saves"),
                .tipsFlag : Endpoint(path: "tips/:tip_id/flag", method: .POST, requiredParameters: ["problem"], requiresUser: true),
                .tipsLike : Endpoint(path: "tips/:tip_id/like", method: .POST, requiresUser: true),
                .tipsUnmark : Endpoint(path: "tips/:tip_id/unmark", method: .POST, requiresUser: true),
                
                // Lists
                
                .lists : Endpoint(path: "lists/:list_id"),
                .listsAdd : Endpoint(path: "lists/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .listsFollowers : Endpoint(path: "lists/:list_id/followers"),
                .listsItems : Endpoint(path: "lists/:list_id/:item_id", requiresUser: true),
                .listsSaves : Endpoint(path: "lists/:list_id/saves"),
                .listsSuggestPhoto : Endpoint(path: "lists/:list_id/suggestphoto", requiredParameters: ["itemId"], requiresUser: true),
                .listsSuggestTip : Endpoint(path: "lists/:list_id/suggesttip", requiredParameters: ["itemId"], requiresUser: true),
                .listsSuggestVenues : Endpoint(path: "lists/:list_id/suggestvenues", requiresUser: true),
                .listsAddItem : Endpoint(path: "lists/:list_id/additem", method: .POST, requiredParameters: ["venueId,tipId,itemId"], requiresUser: true),
                .listsDeleteItem : Endpoint(path: "lists/:list_id/deleteitem", method: .POST, requiredParameters: ["venueId,tipId,itemId"], requiresUser: true),
                .listsFollow : Endpoint(path: "lists/:list_id/follow", method: .POST, requiresUser: true),
                .listsMoveItem : Endpoint(path: "lists/:list_id/moveitem", method: .POST, requiredParameters: ["itemId","beforeId,afterId"], requiresUser: true),
                .listsShare : Endpoint(path: "lists/:list_id/share", method: .POST, requiresUser: true),
                .listsUnfollow : Endpoint(path: "lists/:list_id/unfollow", method: .POST, requiresUser: true),
                .listsUpdate : Endpoint(path: "lists/:list_id/update", method: .POST, requiresUser: true),
                .listsUpdateItem : Endpoint(path: "lists/:list_id/updateitem", method: .POST, requiredParameters: ["itemId"], requiresUser: true),
                
                // Updates
                
                .updates : Endpoint(path: "updates/:update_id", requiresUser: true),
                .updatesNotifications : Endpoint(path: "updates/notifications", requiresUser: true),
                .updatesMarkNotificationsRead : Endpoint(path: "updates/marknotificationsread", method: .POST, requiredParameters: ["highWatermark"], requiresUser: true),
                
                // Photos
                
                .photos : Endpoint(path: "photos/:photo_id", requiresUser: true),
                .photosAdd : Endpoint(path: "photos/add", method: .POST, requiresUser: true),
                
                // Settings
                
                .settings : Endpoint(path: "settings/:setting_id", requiresUser: true),
                .settingsAll : Endpoint(path: "settings/all", requiresUser: true),
                .settingsSet : Endpoint(path: "settings/:setting_id/set", method: .POST, requiredParameters: ["value"], requiresUser: true),
                
                // Specials
                
                .specials : Endpoint(path: "specials/:special_id", requiredParameters: ["venueId"]),
                .specialsAdd : Endpoint(path: "specials/add", method: .POST, requiredParameters: ["text","type"], requiresUser: true),
                .specialsList : Endpoint(path: "specials/list", requiresUser: true),
                .specialsSearch : Endpoint(path: "specials/search", requiredParameters: ["ll"]),
                .specialsFlag : Endpoint(path: "specials/:special_id/flag", method: .POST, requiredParameters: ["venueId","problem"], requiresUser: true),
                
                // Events
                
                .events : Endpoint(path: "events/:event_id", requiresUser: true),
                .eventsCategories : Endpoint(path: "events/categories"),
                .eventsSearch : Endpoint(path: "events/search", requiredParameters: ["domain","eventId,participantId"]),
                .eventsAdd : Endpoint(path: "events/add", method: .POST, requiresUser: true),
                
                // Pages
                
                .pagesAdd : Endpoint(path: "pages/add", method: .POST, requiredParameters: ["name"], requiresUser: true),
                .pagesManaging : Endpoint(path: "pages/managing", requiresUser: true),
                .pagesAccess : Endpoint(path: "pages/:user_id/access", requiresUser: true),
                .pagesSimilar : Endpoint(path: "pages/:user_id/similar", requiresUser: true),
                .pagesTimeSeries : Endpoint(path: "pages/:page_id/timeseries", requiredParameters: ["startAt"], requiresUser: true),
                .pagesVenues : Endpoint(path: "pages/:page_id/venues"),
                .pagesFollow : Endpoint(path: "pages/:user_id/follow", method: .POST, requiresUser: true),
                
                // Page Updates
                
                .pageUpdates : Endpoint(path: "pageupdates/:update_id", requiresUser: true),
                .pageUpdatesAdd : Endpoint(path: "pageupdates/add", method: .POST, requiredParameters: ["pageId"], requiresUser: true),
                .pageUpdatesList : Endpoint(path: "pageupdates/list", requiresUser: true),
                .pageUpdatesDelete : Endpoint(path: "pageupdates/:update_id/delete", method: .POST, requiresUser: true),
                .pageUpdatesLike : Endpoint(path: "pageupdates/:update_id/like", method: .POST, requiresUser: true),
                
                // Multi
                
                .multiGET : Endpoint(path: "multi", requiredParameters: ["requests"]),
                .multiPOST : Endpoint(path: "multi", method: .POST, requiredParameters: ["requests"])
                
            ]
            
        }
        
    }
    
}
