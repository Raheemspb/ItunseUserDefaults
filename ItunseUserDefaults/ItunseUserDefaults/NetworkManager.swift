//
//  NetworkManager.swift
//  ItunseUserDefaults
//
//  Created by Рахим Габибли on 19.07.2024.
//

import Foundation

struct AlbumName: Codable {
    let results: [Album]
}

struct Album: Codable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: String
    let trackCount: Int
}

class NetworkManager {

    static let shared = NetworkManager()
    let defaults = UserDefaults.standard

    func fetchAlbum(albumName: String) -> String {
        let url = "https://itunes.apple.com/search?term=\(albumName)&entity=album&attribute=albumTerm"
        return url
    }

    func getCharacter(albumName: String, completionHandler: @escaping ([Album]) -> Void) {
        let urlString = fetchAlbum(albumName: albumName)
        guard let url = URL(string: urlString) else {
            print("Error")
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                print("Error:", error.localizedDescription)
                return
            }

            guard let data else {
                print("No data")
                return
            }

            do {
                let album = try JSONDecoder().decode(AlbumName.self, from: data).results
                completionHandler(album)
                print("Good")
            } catch {
                print("Error: ", error.localizedDescription)
            }
        }.resume()
    }

    func saveAlbumsToUserDefaults(_ albums: [Album]) {

        do {
            let encodedData = try JSONEncoder().encode(albums)
            defaults.setValue(encodedData, forKey: "albums")
            print("Albums saved to User Defaults")
        } catch {
            print("Error saving albums to UserDefaults: ", error.localizedDescription)
        }
    }

    func getAlbumsFromUserDefaults() -> [Album]? {

        do {
            if let albumData = defaults.data(forKey: "albums") {
                let decodedData = try? JSONDecoder().decode([Album].self, from: albumData)
                return decodedData
            }
            return nil
        }
    }

    func saveSearchTextToUserDefaults(_ searchText: String) {
        var searchTexts = getSearchTextFromUserDefaults() ?? []
                searchTexts.append(searchText)

        do {
            let encodedData = try JSONEncoder().encode(searchTexts)
                defaults.setValue(encodedData, forKey: "searchText")
            print("Search text saved to User Defaults")
        } catch {
            print("Error saving search text: ", error.localizedDescription)
        }

    }

    func getSearchTextFromUserDefaults() -> [String]? {
            if let searchTextData = defaults.data(forKey: "searchText") {
                let decodedData = try? JSONDecoder().decode([String].self, from: searchTextData)
                return decodedData
            }
        return nil
    }
}
