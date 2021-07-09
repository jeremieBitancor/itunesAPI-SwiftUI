//
//  TrackData.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 5/18/21.
//

import Foundation

struct Result: Codable {
    
    let results: [Track]
}

struct Track: Codable, Identifiable {
    
    var id: Int {
        return trackId
    }
    
    var trackPriceString: String {
        return String(format: "%.2f", trackPrice)
    }

    var trackId: Int
    var trackName: String
    var trackPrice: Double
    var primaryGenreName: String
    var longDescription: String
    var artworkUrl100: String
    var previewUrl: String
    
}
