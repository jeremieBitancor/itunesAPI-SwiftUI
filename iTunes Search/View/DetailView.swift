//
//  DetailView.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 5/19/21.
//

import SwiftUI
import AVKit
import URLImage


struct DetailView: View {
    
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(sortDescriptors: [])
    private var favoriteTrackList: FetchedResults<FavoriteTrack>
    
    let track: Track
    private let isFavorite = false
    @State private var iconName: String = "suit.heart"
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading){
                HStack{
                    URLImage(url: URL(string: track.artworkUrl100)!) { image in
                        image
                    }
                    VStack(alignment: .leading){
                        Text(track.trackName)
                        Text(track.primaryGenreName)
                            .foregroundColor(.gray)
                        Text(track.trackPriceString)
                            .foregroundColor(.gray)
                    }
                    
                }
                Text(track.longDescription)
                    .foregroundColor(.black)
                Spacer()
            }
            .padding()
        }
        .onAppear(perform: {
            if checkFavorite(){
                iconName = "suit.heart.fill"
            }
        })
      
        .navigationBarItems(trailing: HStack {
            Image(systemName: iconName)
                .resizable()
                .frame(width: 20, height: 20, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                .foregroundColor(.red)
                .onTapGesture {
                    /// Change icon whether its favorite or not
                    if checkFavorite() {
                        iconName = "suit.heart"
                        removeFromFavorites(id: track.trackId)
                        
                    } else {
                        iconName = "suit.heart.fill"
                        addTrackToFavorite()
                    }
                    
                }
            
        })
    }
    
    /// Checks if selected track is already in favorites
    private func checkFavorite() -> Bool {
        let trackFound = favoriteTrackList.first {$0.id == track.id}
        if trackFound != nil {
            return true
        }
        return false
    }
    
    /// Remove selected track from favorites
    private func removeFromFavorites(id: Int) {
        withAnimation {
            let track = favoriteTrackList.first {$0.id == id}
            viewContext.delete(track!)
            saveContext()
        }
    }
    
    /// Add track to favorites
    private func addTrackToFavorite() {
        let newTrack = FavoriteTrack(context: viewContext)
        newTrack.id = Int64(track.id)
        newTrack.name = track.trackName
        newTrack.genre = track.primaryGenreName
        newTrack.price = track.trackPriceString
        newTrack.desc = track.longDescription
        newTrack.image = track.artworkUrl100
        
        saveContext()
    }
    
    /// Saves context
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("Unresolve error: \(error)")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    
    static let track = Track(trackId: 123, trackName: "Hello", trackPrice: 10.00, primaryGenreName: "Action", longDescription: "Hello Hello Hello", artworkUrl100: "photo", previewUrl: "URL")
    
    
    static var previews: some View {
        DetailView(track: track)
    }
}
