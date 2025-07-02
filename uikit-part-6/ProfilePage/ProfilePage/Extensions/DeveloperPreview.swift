//
//  DeveloperPreview.swift
//  ProfilePage
//
//  Created by Marcin Wawer on 01-07-2025.
//

import Foundation

final class DeveloperPreview {
    
    private init() { }
    
    static let shared = DeveloperPreview()
    
    var user = User(
        name: "Marcin",
        profilePhotoURL: "cat",
        bio: """
        Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. 
        Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. 
        Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. 
        Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.
        """,
        followersCount: 121972,
        followingCount: 12,
        postsCount: 33
    )
}
