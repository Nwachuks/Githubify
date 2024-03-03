//
//  PersistenceManager.swift
//  Githubify
//
//  Created by Nwachukwu Ejiofor on 03/03/2024.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}

enum PersistenceManager {
    static private let defaults = UserDefaults.standard
    
    enum Keys {
        static let favorites = "favorites"
    }
    
    static func updateWith(favourite: Follower, actionType: PersistenceActionType, completion: @escaping (AppError?) -> Void) {
        retrieveFavorites { result in
            switch result {
            case .success(let favourites):
                 var retrievedFavorites = favourites
                
                switch actionType {
                case .add:
                    guard !retrievedFavorites.contains(favourite) else {
                        completion(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favourite)
                case .remove:
                    retrievedFavorites.removeAll { $0.login == favourite.login }
                }
                completion(save(favorites: retrievedFavorites))
            case .failure(let failure):
                completion(failure)
            }
        }
    }
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], AppError>) -> Void) {
        guard let favoritesData = defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.success([]))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: favoritesData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    static func save(favorites: [Follower]) -> AppError? {
        do {
            let encoder = JSONEncoder()
            let encodedFavorites = try encoder.encode(favorites)
            defaults.setValue(encodedFavorites, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
}
