//
//  ContentView.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 5/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var networkManager = NetworkManager()
    @State private var searchText: String = ""
    @State private var isEditing = false
    @State private var lastOpen = UserDefaults.standard.string(forKey: "LastOpenDate")
    
    var body: some View {
        NavigationView {
            VStack{
                ZStack{
                    Rectangle()
                        .foregroundColor(Color(.systemGray6))
                    HStack {
                        Image(systemName: "magnifyingglass")
                        TextField("Search movies", text: $searchText, onEditingChanged: { edit in
                            if edit {
                                isEditing = edit
                            }
                        }, onCommit: {
                            self.networkManager.fetchData(searchString: searchText)
                        })
                        .foregroundColor(.black)
                        
                        if isEditing {
                            Image(systemName: "xmark.circle.fill")
                                .padding()
                                .onTapGesture {
                                    self.searchText = ""
                                }
                        }
                    }
                    .foregroundColor(.gray)
                    .padding(.leading, 13)
                }
                .frame(height: 40)
                .cornerRadius(13)
                .padding()
                
                if networkManager.tracks.count > 0 {
                    List {
                        Section(header: Text(lastOpen ?? "")) {
                            ForEach(networkManager.tracks) { track in
                                MovieRow(track: track)
                            }
                        }
                    }
                    .listStyle(PlainListStyle())
                    
                } else {
                    Text("Error")
                    Spacer()
                }
            }
            .navigationTitle("Movies")
            .navigationBarItems(trailing: NavigationLink("Favorites", destination: FavoritesView()))
            
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(perform: {
            self.networkManager.fetchData(searchString: "star")
            getDate()
        })
        
    }
    
    /// Get date when app starts
    private func getDate() {
        let today = Date()
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        let formattedDate = formatter.string(from: today)
        UserDefaults.standard.setValue(formattedDate, forKey: "LastOpenDate")
    }
}



struct ContentView_Previews: PreviewProvider {
    
    static var previews: some View {
        ContentView()
    }
}

