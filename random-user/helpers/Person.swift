//
//  Exercice_3.swift
//  Exercises
//
//  Created by Neil Richter on 02/12/2018.
//  Copyright © 2018 Neil Richter. All rights reserved.
//
import Foundation

extension String {
    func toDate(format: String) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.date(from: self)!
    }
}

extension Date {
    func toString(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    func getYearDifferenceFrom(date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: self, to: date).year!
    }
}

struct Email: CustomStringConvertible {
    var description: String {
        return self.email!
    }
    
    var email: String?
    
    init (email: String) {
        self.email = email
    }
    
    func isValid() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.email)
    }
    
}

class Existence {
    var birthdate: Date
    var age: Int
    
    init(date: Date?) {
        self.age = date!.getYearDifferenceFrom(date: Date())
        self.birthdate = date!
    }
    
    func willProbablyDieSoon() -> Bool {
        return self.age > 80
    }
}

class Person: Existence {
    enum Gender: String {
        case male = "male", female = "female", other = "other"
    }
    
    var pp: String
    var gender: Gender
    var firstname: String
    var lastname: String
    var email: Email
    
    init(firstname: String, lastname: String, pp: String, gender: Gender, email: Email, birthdate: Date) {
        self.firstname = firstname
        self.lastname = lastname
        self.pp = pp
        self.gender = gender
        self.email = email
        super.init(date: birthdate)
        self.birthdate = birthdate
    }
    
    func show() {
        
        print("firstname : \(self.firstname) ")
        print("lastname : \(self.lastname) ")
        
        switch self.gender {
        case .male:
            print("gender : Male")
        case .female:
            print("gender : Female")
        case .other:
            print("gender : Other")
        }
        
        print("email valid : \(self.email.isValid())")
        print("email : \(self.email)")
        
        print("birthdate : \(self.birthdate)")
        print("age : \(self.age)")
        print("will die soon : \(self.willProbablyDieSoon())")
        
    }
}
