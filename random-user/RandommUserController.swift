//
//  File.swift
//  random-user
//
//  Created by Neil Richter on 22/01/2019.
//  Copyright © 2019 Neil Richter. All rights reserved.
//

import UIKit

class RandomUserController: UIViewController {
    var person: Person?
    
    @IBOutlet weak var picture: UIImageView!
    @IBOutlet weak var fullName: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var birthdate: UILabel!
    @IBAction func backToHome(_ sender: UIButton) {
        self.performSegue(withIdentifier: "randomToHome", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: self.person!.pp)
        let data = try? Data(contentsOf: url!)
        picture.image = UIImage(data: data!);
        
        let firstname = self.person!.firstname.capitalizingFirstLetter()
        let lastname = self.person!.lastname.capitalizingFirstLetter()
        self.fullName.text = [firstname, lastname].joined(separator: " ")
        self.gender.text = self.person!.gender.rawValue
        self.birthdate.text = self.person!.birthdate.toString(format: "MM/dd/yyyy")
    }
}
