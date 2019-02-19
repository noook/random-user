//
//  ViewController.swift
//  random-user
//
//  Created by Neil Richter on 22/01/2019.
//  Copyright © 2019 Neil Richter. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var main_title: UILabel!
    
    @IBAction func clearCache(_ sender: UIButton) {
        Storage.clearUserData()
        let alert = UIAlertController(title: "",
                                      message: "Cache cleared !",
                                      preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(OKAction)
        self.present(alert, animated: true)
    }
    
    @IBAction func goToRandomUser(_ sender: UIButton) {
        if (Storage.getUser.firstname == nil) {
            apiManager().getRandomUserHydratedWithPerson(completion: {
                person in
                Storage.saveUser(
                    person.firstname,
                    person.lastname,
                    person.email.email!,
                    person.gender.rawValue,
                    person.birthdate.toString(format: "yyyy-MM-dd'T'HH:mm:ssZ"),
                    person.pp
                )
                DispatchQueue.main.async {
                    self.performSegue(withIdentifier: "goToRandomPerson", sender: person)
                }
            })
        } else {
            let data = Storage.getUser
            let person = Person(
                firstname: data.firstname!,
                lastname: data.lastname!,
                pp: data.pp!,
                gender: Person.Gender(rawValue: data.gender!)!,
                email: Email(email: data.email!),
                birthdate: data.birthdate!
            )
            self.performSegue(withIdentifier: "goToRandomPerson", sender: person)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let person = sender as! Person
        let vc = segue.destination as! RandomUserController
        vc.person = person
    }
    
    override func viewDidLoad() {
        main_title.text = "Random User App"
    
        super.viewDidLoad()
    }
    
}

struct Storage {
    static let (
        firstNameKey,
        lastNameKey,
        emailKey,
        genderKey,
        birthdateKey,
        pictureKey
    ) = (
        "firstname",
        "lastname",
        "email",
        "gender",
        "birthdate",
        "pp"
    )
    static let userSessionKey = "com.save.usersession"
    
    struct Model {
        var firstname: String?
        var lastname: String?
        var email: String?
        var gender: String?
        var birthdate: Date?
        var pp: String?
        
        init(_ json: [String: String]) {
            self.firstname = json[firstNameKey]
            self.lastname = json[lastNameKey]
            self.email = json[emailKey]
            self.gender = json[genderKey]
            self.birthdate = json[birthdateKey]?.toDate(format: "yyyy-MM-dd'T'HH:mm:ssZ")
            self.pp = json[pictureKey]
        }
    }
    
    static var saveUser = { (
        firstname: String,
        lastname: String,
        email: String,
        gender: String,
        birthdate: String,
        pp: String
        ) in
        UserDefaults.standard.set([
            firstNameKey: firstname,
            lastNameKey: lastname,
            emailKey: email,
            pictureKey: pp,
            genderKey: gender,
            birthdateKey: birthdate
            ], forKey: userSessionKey)
    }
    
    static var getUser = { _ -> Model in
        return Model((UserDefaults.standard.value(forKey: userSessionKey) as? [String: String]) ?? [:])
    }(())
    
    static func clearUserData(){
        print("FIRST", UserDefaults.standard.dictionaryRepresentation())
        UserDefaults.standard.removeObject(forKey: userSessionKey)
        print("SECOND", UserDefaults.standard.dictionaryRepresentation())
    }
}
