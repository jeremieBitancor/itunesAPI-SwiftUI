//
//  MovieRow.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 5/19/21.
//

import SwiftUI
import URLImage

struct MovieRow: View {
    
    var track: Track
    
    var body: some View {
        NavigationLink(
            destination: DetailView(track: track),
            label: {
                HStack {
                    URLImage(url: URL(string: track.artworkUrl100)!) { image in
                        image
                    }
                    VStack(alignment: .leading) {
                        Text(track.trackName)
                        Text(track.primaryGenreName)
                            .foregroundColor(.gray)
                        Text(track.trackPriceString)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                }
            })

    }
}

struct MovieRow_Previews: PreviewProvider {
    
    static let track = Track(trackId: 123, trackName: "Hello", trackPrice: 10.00, primaryGenreName: "Action", longDescription: "Hello Hello Hello", artworkUrl100: "photo", previewUrl: "URL")
    
    static var previews: some View {
        MovieRow(track: track)
    }
}
