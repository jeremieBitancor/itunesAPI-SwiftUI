//
//  NetworkManager.swift
//  iTunes Search
//
//  Created by jeremie bitancor on 5/18/21.
//

import Foundation

class NetworkManager: ObservableObject {
    
    @Published var tracks = [Track]()

    func fetchData(searchString: String) {
        print(searchString)
        // Create URL
        if let url = URL(string: "https://itunes.apple.com/search?term=\(searchString)&country=au&media=movie&all") {
            // Create URL Session
            let session = URLSession(configuration: .default)
            // Give session a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error == nil {
                    let decoder = JSONDecoder()
                    if let safeData = data {
                        do {
                            let decodedResult = try decoder.decode(Result.self, from: safeData)
//                            print(decodedResult)
                            DispatchQueue.main.async {
                                self.tracks = decodedResult.results
                            }
                        } catch {
                            print("Error: \(error.localizedDescription)")
                        }
                    }
                }
            }
            // Start the task
            task.resume()

        }
        
    }
}
