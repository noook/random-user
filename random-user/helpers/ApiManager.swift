//
//  Exercice_4.swift
//  Exercises
//
//  Created by Neil Richter on 29/11/2018.
//  Copyright © 2018 Neil Richter. All rights reserved.
//
import Foundation

class apiManager {
    var baseUrl: String = "https://api.randomuser.me/"
    
    func getRandomUser(completing: @escaping (Any) -> Void) {
        var request = URLRequest(url: URL(string: self.baseUrl)!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, err in
            do {
                let json = try? JSONSerialization.jsonObject(with: data!, options: [])
                completing(json!)
            } catch let error as NSError {
                print(error)
            }
            }.resume()
    }
}
