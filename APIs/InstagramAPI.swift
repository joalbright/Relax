//
//  InstagramAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/12/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://www.instagram.com/developer/

private let _ig = InstagramAPI()

open class InstagramAPI: API {
    
    open override class func session() -> InstagramAPI { return _ig }
    
    open override func start() {
        
        baseURL = "https://api.instagram.com/v1/"
        authURL = "https://api.instagram.com/oauth/"
        authHeader = "Authorization"
        authTokenKey = "Instagram"
        authBasic = [
            
            "client_id" : INSTAGRAM_CLIENT_ID,
            "client_secret" : INSTAGRAM_CLIENT_SECRET,
            "access_token":"ACCESS_TOKEN"
        
        ]
        
    }
    
    open override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.auth.endpoint
        
        auth.parameters = [
            
            "client_id" : INSTAGRAM_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co"
            
        ]
        
        var authCode = Endpoints.authCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : INSTAGRAM_CLIENT_ID,
            "client_secret" : INSTAGRAM_CLIENT_SECRET,
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
        case usersMe
        case usersMedia
        case usersMyMedia
        case usersMyMediaLiked
        case usersSearch
        
        // Relationships
        
        case usersMyFollows
        case usersMyFollowers
        case usersRequestedFollow
        case usersRelationship
        case usersSetRelationship
        
        // Media
        
        case media
        case mediaShortcode
        case mediaSearch
        
        // Comments
        
        case mediaComments
        case mediaCommentsAdd
        case mediaCommentsDelete
        
        // Likes
        
        case mediaLikes
        case mediaLikesAdd
        case mediaLikesDelete
        
        // Tags
        
        case tags
        case tagsMedia
        case tagsSearch
        
        // Locations
        
        case locations
        case locationsMedia
        case locationsSearch
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .auth : Endpoint(path: "authorize", requiredParameters: ["client_id","response_type","redirect_uri"]),
                .authCode : Endpoint(path: "access_token", method: .POST, requiredParameters: ["client_id","client_secret","grant_type","redirect_uri","code"]),
            
                // Users
                
                .users : Endpoint(path: "users/:user_id", requiresUser: true),
                .usersMe : Endpoint(path: "users/:user_id", requiresUser: true),
                .usersMedia : Endpoint(path: "users/:user_id/media/recent", requiresUser: true),
                .usersMyMedia : Endpoint(path: "users/self/media/recent", requiresUser: true),
                .usersMyMediaLiked : Endpoint(path: "users/self/media/liked", requiresUser: true),
                .usersSearch : Endpoint(path: "users/search", requiredParameters: ["r"], requiresUser: true),
                
                // Relationships
                
                .usersMyFollows : Endpoint(path: "users/self/follows", requiresUser: true),
                .usersMyFollowers : Endpoint(path: "users/self/followed-by", requiresUser: true),
                .usersRequestedFollow : Endpoint(path: "users/self/requested-by", requiresUser: true),
                .usersRelationship : Endpoint(path: "users/:user_id/relationship", requiresUser: true),
                .usersSetRelationship : Endpoint(path: "users/:user_id/relationship", method: .POST, requiresUser: true),
                
                // Media
                
                .media : Endpoint(path: "media/:media_id", requiresUser: true),
                .mediaShortcode : Endpoint(path: "media/shortcode/:shortcode", requiresUser: true),
                .mediaSearch : Endpoint(path: "media/search", requiredParameters: ["lat","lng"], requiresUser: true),
                
                // Comments
                
                .mediaComments : Endpoint(path: "media/:media_id/comments", requiresUser: true),
                .mediaCommentsAdd : Endpoint(path: "media/:media_id/comments", method: .POST, requiresUser: true),
                .mediaCommentsDelete : Endpoint(path: "media/:media_id/comments/:comment_id", method: .DELETE, requiresUser: true),
                
                // Likes
                
                .mediaLikes : Endpoint(path: "media/:media_id/likes", requiresUser: true),
                .mediaLikesAdd : Endpoint(path: "media/:media_id/likes", method: .POST, requiresUser: true),
                .mediaLikesDelete : Endpoint(path: "media/:media_id/likes", method: .DELETE, requiresUser: true),
                
                // Tags
                
                .tags : Endpoint(path: "tags/:tag_name", requiresUser: true),
                .tagsMedia : Endpoint(path: "tags/:tag_name/media/recent", requiresUser: true),
                .tagsSearch : Endpoint(path: "tags/search", requiredParameters: ["q"], requiresUser: true),
                
                // Locations
                
                .locations : Endpoint(path: "locations/:location_id", requiresUser: true),
                .locationsMedia : Endpoint(path: "locations/:location_id/media/recent", requiresUser: true),
                .locationsSearch : Endpoint(path: "locations/search", requiredParameters: ["facebook_places_id,lat,lng,foursquare_id,foursquare_v2_id"], requiresUser: true)
                
            ]
            
        }
        
    }

}
