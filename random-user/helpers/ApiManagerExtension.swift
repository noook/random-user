//
//  Exercice_5.swift
//  Exercises
//
//  Created by Neil Richter on 02/12/2018.
//  Copyright © 2018 Neil Richter. All rights reserved.
//
import Foundation

extension apiManager {
    func getRandomUserHydratedWithPerson(completion: @escaping (Person) -> Void) {
        self.getRandomUser(completing: { data in
            let json = data as! [String: Any]
            let dict = json["results"] as! [[String: Any]]
            let results = dict[0]
            let name = results["name"] as! [String: String]
            let picture = results["picture"] as! [String: String]
            let dob = results["dob"] as! [String: Any]
            let birthdate = dob["date"] as! String
            let gender = results["gender"]! as! String
            let person = Person(firstname: name["first"]!,
                                lastname: name["last"]!,
                                pp: picture["large"]!,
                                gender: Person.Gender(rawValue: gender)!,
                                email: Email(email: results["email"]! as! String),
                                birthdate: birthdate.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ"))
            completion(person)
        })
    }
}
