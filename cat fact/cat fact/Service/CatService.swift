//
//  CatService.swift
//  cat fact
//
//  Created by sushil tiwari on 04/10/24.
//

import Foundation

import Foundation

class CatService {
    
    // Fetch random cat image
    func fetchRandomCatImage(completion: @escaping (CatImage?) -> Void) {
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let imageResponse = try? JSONDecoder().decode([CatImage].self, from: data)
            completion(imageResponse?.first) // The API returns an array, so we take the first element
        }.resume()
    }
    
    // Fetch random cat fact
    func fetchRandomCatFact(completion: @escaping (String?) -> Void) {
        guard let url = URL(string: "https://meowfacts.herokuapp.com/?lang=eng") else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            
            let factResponse = try? JSONDecoder().decode(CatFact.self, from: data)
            completion(factResponse?.data.first) // The fact is the first element in the array
        }.resume()
    }
}
