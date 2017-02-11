//
//  ItunesSearch.swift
//  Relax
//
//  Created by Jo Albright on 2/10/17.
//  Copyright © 2017 CocoaPods. All rights reserved.
//

import UIKit

//["results": <__NSArrayM 0x170054850>(
//    {
//    amgArtistId = 168791;
//    artistId = 5468295;
//    artistName = "Daft Punk";
//    artistViewUrl = "https://itunes.apple.com/us/artist/daft-punk/id5468295?uo=4";
//    artworkUrl100 = "http://is5.mzstatic.com/image/thumb/Music2/v4/0c/8c/4a/0c8c4a84-465f-ee54-d999-eb0743d224ef/source/100x100bb.jpg";
//    artworkUrl60 = "http://is5.mzstatic.com/image/thumb/Music2/v4/0c/8c/4a/0c8c4a84-465f-ee54-d999-eb0743d224ef/source/60x60bb.jpg";
//    collectionCensoredName = "Random Access Memories";
//    collectionExplicitness = notExplicit;
//    collectionId = 617154241;
//    collectionName = "Random Access Memories";
//    collectionPrice = "11.99";
//    collectionType = Album;
//    collectionViewUrl = "https://itunes.apple.com/us/album/random-access-memories/id617154241?uo=4";
//    copyright = "\U2117 2013 Daft Life Limited under exclusive license to Columbia Records, a Division of Sony Music Entertainment";
//    country = USA;
//    currency = USD;
//    primaryGenreName = Pop;
//    releaseDate = "2013-05-17T07:00:00Z";
//    trackCount = 14;
//    wrapperType = collection;
//    },
//    {
//    artistId = 587765573;
//    artistName = "Chris Hawk";
//    artistViewUrl = "https://itunes.apple.com/us/artist/chris-hawk/id587765573?uo=4";
//    artworkUrl100 = "http://is1.mzstatic.com/image/thumb/Music4/v4/03/48/ca/0348ca9e-48af-25a1-3fa5-4d4ebe7ff8cf/source/100x100bb.jpg";
//    artworkUrl60 = "http://is1.mzstatic.com/image/thumb/Music4/v4/03/48/ca/0348ca9e-48af-25a1-3fa5-4d4ebe7ff8cf/source/60x60bb.jpg";
//    collectionCensoredName = "Random Daft Guitars (An Unplugged Daft Punk Tribute) - Single";
//    collectionExplicitness = notExplicit;
//    collectionId = 703297612;
//    collectionName = "Random Daft Guitars (An Unplugged Daft Punk Tribute) - Single";
//    collectionPrice = "3.87";
//    collectionType = Album;
//    collectionViewUrl = "https://itunes.apple.com/us/album/random-daft-guitars-unplugged/id703297612?uo=4";
//    copyright = "\U2117 2013 No\U00ebl Akchot\U00e9";
//    country = USA;
//    currency = USD;
//    primaryGenreName = House;
//    releaseDate = "2013-09-09T07:00:00Z";
//    trackCount = 3;
//    wrapperType = collection;
//    }
//    )
//    , "resultCount": 50]

class ItunesSearch: RelaxObject {
    
    var results: [ItunesMedia] = []
    var resultCount: Int?
    
    required init(_ info: ParsedInfo) {
        super.init(info)
        
        results <-- info["results"]
        resultCount <-- info["resultCount"]
        
    }
    
}

class ItunesMedia: RelaxObject {
    
    var artistName: String?
    var collectionName: String?

    //    amgArtistId = 168791;
    //    artistId = 5468295;
    //    artistName = "Daft Punk"
    //    artistViewUrl = "https://itunes.apple.com/us/artist/daft-punk/id5468295?uo=4";
    //    artworkUrl100 = "http://is5.mzstatic.com/image/thumb/Music2/v4/0c/8c/4a/0c8c4a84-465f-ee54-d999-eb0743d224ef/source/100x100bb.jpg";
    //    artworkUrl60 = "http://is5.mzstatic.com/image/thumb/Music2/v4/0c/8c/4a/0c8c4a84-465f-ee54-d999-eb0743d224ef/source/60x60bb.jpg";
    //    collectionCensoredName = "Random Access Memories";
    //    collectionExplicitness = notExplicit;
    //    collectionId = 617154241;
    //    collectionName = "Random Access Memories";
    //    collectionPrice = "11.99";
    //    collectionType = Album;
    //    collectionViewUrl = "https://itunes.apple.com/us/album/random-access-memories/id617154241?uo=4";
    //    copyright = "\U2117 2013 Daft Life Limited under exclusive license to Columbia Records, a Division of Sony Music Entertainment";
    //    country = USA;
    //    currency = USD;
    //    primaryGenreName = Pop;
    //    releaseDate = "2013-05-17T07:00:00Z";
    //    trackCount = 14;
    //    wrapperType = collection;
    
    required init(_ info: ParsedInfo) {
        super.init(info)
        
        artistName <-- info["artistName"]
        collectionName <-- info["collectionName"]
        
    }
    
}
