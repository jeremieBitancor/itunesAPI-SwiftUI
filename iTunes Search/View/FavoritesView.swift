//
//  FavoritesView.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 7/8/21.
//

import SwiftUI
import URLImage

struct FavoritesView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(sortDescriptors: [])
    var favoriteTrackList: FetchedResults<FavoriteTrack>
    
    var body: some View {
        List{
            ForEach(favoriteTrackList) { track in
                
                HStack{
                    URLImage(url: URL(string: track.image ?? "")!) { image in
                        image
                    }
                    VStack(alignment: .leading) {
                        Text(track.name ?? "")
                        Text(track.genre ?? "")
                        Text(track.price ?? "")
                    }
                    Spacer()
                    Image(systemName: "suit.heart.fill")
                        .foregroundColor(.red)
                        .onTapGesture {
                            removeFromFavorites(id: track.id)
                        }
                }
               
                
            }
        }
    }
    /// Remove track from favorites using track id
    private func removeFromFavorites(id: Int64) {
        withAnimation {
            let x = favoriteTrackList.first {$0.id == id}
            viewContext.delete(x!)
            saveContext()
        }
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

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        FavoritesView()
    }
}
