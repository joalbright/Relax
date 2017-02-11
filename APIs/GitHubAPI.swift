//
//  GithubAPI.swift
//  Relax
//
//  Created by Jo Albright on 1/11/16.
//  Copyright (c) 2016 Jo Albright. All rights reserved.
//


import Foundation


// Documentation : https://developer.github.com/v3/

private let _gh = GitHubAPI()

open class GitHubAPI: API {
    
    open override class func session() -> GitHubAPI { return _gh }
    
    open override func start() {
        
        baseURL = "https://api.github.com/"
        authURL = "https://github.com/login/oauth/"
        authTokenKey = "Github"
        authBasic = [
            
            "client_id" : GITHUB_CLIENT_ID,
            "client_secret" : GITHUB_CLIENT_SECRET,
            "access_token" : "ACCESS_TOKEN"
            
        ]
        
    }
    
    open override func loginDetails() -> (auth: Endpoint, authCode: Endpoint) {
        
        var auth = Endpoints.auth.endpoint
        
        auth.parameters = [
            
            "client_id" : GITHUB_CLIENT_ID,
            "response_type" : "code",
            "redirect_uri" : "https://code.jo2.co",
            "scope" : "user,public_repo",
            "state" : "thisisawesome"
            
        ]
        
        var authCode = Endpoints.authCode.endpoint
        
        authCode.parameters = [
            
            "client_id" : GITHUB_CLIENT_ID,
            "client_secret" : GITHUB_CLIENT_SECRET,
            "redirect_uri" : "https://code.jo2.co",
            "state" : "thisisawesome"
            
        ]
        
        return (auth, authCode)
        
        
    }
    
    public enum Endpoints: String {
        
        // Auth
        
        case auth
        case authCode
        
        // Events
        
        case events
        case eventsRepo
        case eventsRepoIssues
        case eventsRepoNetworks
        case eventsOrg
        case eventsUserReceived
        case eventsUserReceivedPublic
        case eventsUserPerformed
        case eventsUserPerformedPublic
        case eventsUserOrg
        
        // Notifications
        
        case notifications
        case notificationsMarkRead
        case notificationsRepo
        case notificationsRepoMarkRead
        case notificationsThread
        case notificationsThreadMarkRead
        case notificationsThreadSubscription
        case notificationsThreadSetSubscription
        case notificationsThreadDeleteSubscription
        
        // Stars
        
        case starsRepoStarGazers
        case starsUserStarred
        case starsMeStarred
        case starsRepoCheck
        case starsRepoStar
        case starsRepoUnstar
        
        // Watch
        
        case watchRepoWatchers
        case watchUserWatching
        case watchMeWatching
        case watchRepoSubscription
        case watchRepoSetSubscription
        case watchRepoDeleteSubscription
        case watchRepoCheck
        case watchRepoWatch
        case watchRepoUnwatch
        
        // Gists
        
        case gists
        case gistsUser
        case gistsMe
        case gistsMeStarred
        case gist
        case gistRevision
        case gistCreate
        case gistEdit
        case gistDelete
        case gistCommits
        case gistCheck
        case gistStar
        case gistUnstar
        case gistFork
        case gistForks
        
        // Git Data
        
        // Issues
        
        // Misc
        
        // Org
        
        // Pull Requests
        
        // Repo
        
        // Search
        
        case searchRepos
        case searchCode
        case searchIssues
        case searchUsers
        
        // User
        
        case users
        case usersNamed
        case usersMe
        case usersMeUpdate
        case usersMeEmails
        case usersMeEmailsAdd
        case usersMeEmailsDelete
        case usersFollowers
        case usersMeFollowers
        case usersFollowing
        case usersMeFollowing
        case usersFollowingUserCheck
        case usersMeFollowingUserCheck
        case usersMeFollowUser
        case usersMeUnfollowUser
        
        
        public var endpoint: Endpoint { return _endpoints[self]! }
        
        var _endpoints: [Endpoints:Endpoint] {
            
            return [
                
                // Auth
                
                .auth : Endpoint(path: "authorize", requiredParameters: ["client_id","redirect_uri","state"]),
                .authCode : Endpoint(path: "access_token", requiredParameters: ["client_id","client_secret","code","redirect_uri","state"]),
                
                // Events
                
                .events : Endpoint(path: "events"),
                .eventsRepo : Endpoint(path: "repos/:owner/:repo/events"),
                .eventsRepoIssues : Endpoint(path: "repos/:owner/:repo/issues/events"),
                .eventsRepoNetworks : Endpoint(path: "networks/:owner/:repo/events"),
                .eventsOrg : Endpoint(path: "orgs/:org/events"),
                .eventsUserReceived : Endpoint(path: "users/:username/received_events", requiresUser: true),
                .eventsUserReceivedPublic : Endpoint(path: "users/:username/received_events/public"),
                .eventsUserPerformed : Endpoint(path: "users/:username/events", requiresUser: true),
                .eventsUserPerformedPublic : Endpoint(path: "users/:username/events/public"),
                .eventsUserOrg : Endpoint(path: "users/:username/events/orgs/:org", requiresUser: true),
                
                // Notifications
                
                .notifications : Endpoint(path: "notifications", requiresUser: true),
                .notificationsMarkRead : Endpoint(path: "notifications", method: .PUT, requiresUser: true),
                .notificationsRepo : Endpoint(path: "repos/:owner/:repo/notifications", requiresUser: true),
                .notificationsRepoMarkRead : Endpoint(path: "repos/:owner/:repo/notifications", method: .PUT, requiresUser: true),
                .notificationsThread : Endpoint(path: "notifications/threads/:id", requiresUser: true),
                .notificationsThreadMarkRead : Endpoint(path: "notifications/threads/:id", method: .PATCH, requiresUser: true),
                .notificationsThreadSubscription : Endpoint(path: "notifications/threads/:id/subscription", requiresUser: true),
                .notificationsThreadSetSubscription : Endpoint(path: "notifications/threads/:id/subscription", method: .PUT, requiresUser: true),
                .notificationsThreadDeleteSubscription : Endpoint(path: "notifications/threads/:id/subscription", method: .DELETE, requiresUser: true),
                
                // Stars
                
                .starsRepoStarGazers : Endpoint(path: "repos/:owner/:repo/stargazers"),
                .starsUserStarred : Endpoint(path: "users/:username/starred"),
                .starsMeStarred : Endpoint(path: "user/starred", requiresUser: true),
                .starsRepoCheck : Endpoint(path: "user/starred/:owner/:repo", requiresUser: true),
                .starsRepoStar : Endpoint(path: "user/starred/:owner/:repo", method: .PUT, requiresUser: true),
                .starsRepoUnstar : Endpoint(path: "user/starred/:owner/:repo", method: .DELETE, requiresUser: true),
                
                // Watch
                
                .watchRepoWatchers : Endpoint(path: "repos/:owner/:repo/subscribers"),
                .watchUserWatching : Endpoint(path: "users/:username/subscriptions"),
                .watchMeWatching : Endpoint(path: "user/subscriptions", requiresUser: true),
                .watchRepoSubscription : Endpoint(path: "repos/:owner/:repo/subscription", requiresUser: true),
                .watchRepoSetSubscription : Endpoint(path: "repos/:owner/:repo/subscription", method: .PUT, requiresUser: true),
                .watchRepoDeleteSubscription : Endpoint(path: "repos/:owner/:repo/subscription", method: .DELETE, requiresUser: true),
                .watchRepoCheck : Endpoint(path: "user/subscriptions/:owner/:repo", requiresUser: true),
                .watchRepoWatch : Endpoint(path: "user/subscriptions/:owner/:repo", method: .PUT, requiresUser: true),
                .watchRepoUnwatch : Endpoint(path: "user/subscriptions/:owner/:repo", method: .DELETE, requiresUser: true),
            
                // Gists
                
                .gists : Endpoint(path: "gists/public"),
                .gistsUser : Endpoint(path: "users/:username/gists"),
                .gistsMe : Endpoint(path: "gists", requiresUser: true),
                .gistsMeStarred : Endpoint(path: "gists/starred", requiresUser: true),
                .gist : Endpoint(path: "gists/:id"),
                .gistRevision : Endpoint(path: "gists/:id/:sha"),
                .gistCreate : Endpoint(path: "gists", method: .POST, requiresUser: true),
                .gistEdit : Endpoint(path: "gists/:id", method: .PATCH, requiresUser: true),
                .gistDelete : Endpoint(path: "gists/:id", method: .DELETE, requiresUser: true),
                .gistCommits : Endpoint(path: "gists/:id/commits"),
                .gistCheck : Endpoint(path: "gists/:id/star", requiresUser: true),
                .gistStar : Endpoint(path: "gists/:id/star", method: .PUT, requiresUser: true),
                .gistUnstar : Endpoint(path: "gists/:id/star", method: .DELETE, requiresUser: true),
                .gistFork : Endpoint(path: "gists/:id/forks", method: .POST, requiresUser: true),
                .gistForks : Endpoint(path: "gists/:id/forks"),
                
                // Search
                
                .searchRepos : Endpoint(path: "search/repositories"),
                .searchCode : Endpoint(path: "search/code"),
                .searchIssues : Endpoint(path: "search/issues"),
                .searchUsers : Endpoint(path: "search/users"),
                
                // User
                
                .users : Endpoint(path: "users"),
                .usersNamed : Endpoint(path: "users/:username"),
                .usersMe : Endpoint(path: "user", requiresUser: true),
                .usersMeUpdate : Endpoint(path: "user", method: .PATCH, requiresUser: true),
                .usersMeEmails : Endpoint(path: "user/emails", requiresUser: true),
                .usersMeEmailsAdd : Endpoint(path: "user/emails", method: .POST, requiresUser: true),
                .usersMeEmailsDelete : Endpoint(path: "user/emails", method: .DELETE, requiresUser: true),
                .usersFollowers : Endpoint(path: "users/:username/followers"),
                .usersMeFollowers : Endpoint(path: "user/followers", requiresUser: true),
                .usersFollowing : Endpoint(path: "users/:username/following"),
                .usersMeFollowing : Endpoint(path: "user/following", requiresUser: true),
                .usersFollowingUserCheck : Endpoint(path: "users/:username/following/:target_user"),
                .usersMeFollowingUserCheck : Endpoint(path: "user/following/:username", requiresUser: true),
                .usersMeFollowUser : Endpoint(path: "user/following/:username", method: .PUT, requiresUser: true),
                .usersMeUnfollowUser : Endpoint(path: "user/following/:username", method: .DELETE, requiresUser: true)
                
            ]
            
        }
        
    }

}
