//
//  ViewController.swift
//  hackathon_motion
//
//  Created by Nathan on 3/8/18.
//  Copyright © 2018 Nathan. All rights reserved.
//

//
//  ViewController.swift
//  CoreMotionDemo
//
//  Created by Eli Byers on 7/7/17.
//  Copyright © 2017 Eli Byers. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {
    let north = [
        ["name": "Seattle", "country": "United States", "population": "3,439,809", "food_dishes":"Seattle Dog, Ginger Beer", "climate": "Warm-summer Mediterranean climate", "languages": "English", "image": "seattle"],
        ["name": "Vancouver", "country": "Canada", "population": "603,000", "food_dishes":"JapaDog, Salmon Candy", "climate": "Oceanic climate", "languages": "French, English", "image": "vancouver"],
        ["name": "Quebec City", "country": "Canada", "population": "538,238", "food_dishes":"Poutine, Tarte au sucre", "climate": "Humid continental climate", "languages": "French, English", "image": "quebec"],
        ["name": "San Francisco", "country": "United States of America", "population": "870,887", "food_dishes":"Mission-Style Burrito, Joe’s Special", "climate": "Warm-summer Mediterranean climate", "languages": "English", "image": "sf"],
        ["name": "Anchorage", "country": "United States of America", "population": "291,826", "food_dishes":"Grilled Salmon, Reindeer Dogs", "climate": "Subarctic climate ", "languages": "English", "image": "anchorage"]
    ]
    let east = [
        ["name": "Hong Kong", "country": "People's Republic of China", "population": "7,409,800", "food_dishes":"Dim Sum, Put chai ko", "climate": "Humid subtropical climate ", "languages": "Chinese, English", "image": "hk"],
        ["name": "Tokyo", "country": "State of Japan", "population": "420,076", "food_dishes":"Misonikomi-Udon, Goheimochi", "climate": "Humid subtropical climate ", "languages": "Japanese", "image": "tokyo"],
        ["name": "Seoul", "country": "Republic of Korea", "population": "25,600,000", "food_dishes":"Gukbap, ukgaejang", "climate": "Humid continental climate", "languages": "Korean", "image": "seoul"],
        ["name": "Manila", "country": "Republic of the Philippines", "population": "1,780,148", "food_dishes":"Bicol express, Halo-Halo", "climate": "Tropical savanna climate", "languages": "Tagalog", "image": "manila"],
        ["name": "Kuala Lumpur", "country": "Malaysia", "population": "7,200,000", "food_dishes":"Nasi Lemak, Ais Kacang", "climate": "Equatorial", "languages": "Malay, English", "image": "kl"]
    ]
    
    let west = [
        ["name": "Berlin", "country": "Federal Republic of Germany", "population": "3,711,930", "food_dishes":"Berliner Weisse, Schrippe", "climate": "Maritime temperate climate ", "languages": "German", "image": "berlin"],
        ["name": "Paris", "country": "French Republic", "population": "2,206,488", "food_dishes":"Le Paris-Brest, Le Croque Monsieur", "climate": "Oceanic climate", "languages": "French", "image": "paris"],
        ["name": "London", "country": "United Kingdom", "population": "8,787,892", "food_dishes":"Fish and Chips, ", "climate": "Temperate oceanic climate ", "languages": "English", "image": "london"],
        ["name": "Rome", "country": "Italian Republic", "population": "4,357,041", "food_dishes":"Saltimbocca alla Romana, Fettuccine al Burro", "climate": "Mediterranean climate", "languages": "Italian", "image": "rome"],
        ["name": "Helsinki", "country": "Republic of Finland", "population": "1,470,552", "food_dishes":"Kaalikääryleet,Hernekeitto", "climate": "Humid continental climate", "languages": "Finnish", "image": "helsinki"]
    ]
    
    let south = [
        ["name": "Rio de Janeiro", "country": "Federative Republic of Brazil ", "population": "7,456,682", "food_dishes":"", "climate": "", "languages": "Portuguese", "image": "rio"],
        ["name": "Mexico City", "country": "United Mexican States", "population": "8,918,653", "food_dishes":"Tortas de Tamales, Gorditas", "climate": "Subtropical highland climate ", "languages": "Spanish", "image": "mc"],
        ["name": "Buenos Aires", "country": "Argentine Republic", "population": "13,591,863", "food_dishes":"Asados, Chimichurri", "climate": "Humid subtropical climate", "languages": "Spanish", "image": "ba"],
        ["name": "Santiago", "country": "Chile", "population": "7,314,176", "food_dishes":"Pastel de Choclo, Cazuela", "climate": "Semi-arid climate", "languages": "Spanish", "image": "santiago"],
        ["name": "Panama City", "country": "Panama", "population": "880,691", "food_dishes":"Plantains,Hojaldras", "climate": "Tropical savanna climate", "languages": "Spanish", "image": "pc"]
    ]

    
    @IBOutlet weak var photoView: UIImageView!
    
    
    @IBOutlet weak var SpinmeLabel: UILabel!
    
    @IBOutlet weak var locationView: UIView!
    
    @IBOutlet weak var languagesLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var countryLabel: UILabel!
    
    
    @IBOutlet weak var climateLabel: UILabel!
    @IBOutlet weak var food_dishesLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    
    @IBOutlet weak var shakeDirLabel: UILabel!
    
    @IBOutlet weak var popupBack: UIView!
    
    @IBAction func stopButton(_ sender: UIButton) {
        let city = newCity(quad: direction)
        motionManager.stopMagnetometerUpdates()
        displayData(city: city)
        if direction == "North" {
            popupBack.backgroundColor = UIColor(red:0.82, green:0.90, blue:0.96, alpha:1.0)
        }
        if direction == "South" {
            popupBack.backgroundColor = UIColor(red:0.96, green:0.82, blue:0.78, alpha:1.0)
        }
        if direction == "East" {
            popupBack.backgroundColor = UIColor(red:0.96, green:0.96, blue:0.59, alpha:1.0)
        }
        if direction == "West" {
            popupBack.backgroundColor = UIColor(red:0.83, green:0.96, blue:0.93, alpha:1.0)
        }
        
        locationView.isHidden = false
        
    }
   
    @IBAction func resetButton(_ sender: Any) {
        if motionManager.isMagnetometerAvailable {
            print("We can detect device direction")
            startReadingMotionData()
        }
        else {
            print("We cannot detect device direction")
        }
        locationView.isHidden = true

    }
    
    func displayData (city: [String:String]) {
        if let nameUW = city["name"] {
          cityLabel.text = "\(nameUW)"
        }
        else {
           cityLabel.text = "San Jose"
        }
        if let countryUW = city["country"] {
            countryLabel.text = "\(countryUW)"
        }
        else {
            countryLabel.text = "United States"
        }
        if let popUW = city["population"] {
            populationLabel.text = "population: \(popUW)"
        }
        else {
            populationLabel.text = "population: 1 millie"
        }
        if let foodUW = city["food_dishes"] {
            food_dishesLabel.text = "popular dishes: \(foodUW)"
        }
        else {
            food_dishesLabel.text = "popular dishes: tacos"
        }
        
        if let climateUW = city["climate"] {
            climateLabel.text = "climate: \(climateUW)"
        }
        else {
           climateLabel.text = "climate: Always sunny"
        }
        if let langUW = city["languages"] {
            languagesLabel.text = "languages: \(langUW)"
        }
        else {
            languagesLabel.text = "languages: English"
        }
        if let imgUW = city["image"] {
            photoView.image = UIImage(named: "\(imgUW)")
        }
        else {
            photoView.image = UIImage(named: "paris")
        }
        
        shakeDirLabel.text = "Shake phone or press button to view another city \(direction) of here"
    }
    
    var motionManager = CMMotionManager()
    let opQueue = OperationQueue()
    var magnetometerData: CMMagnetometerData?
    var x: Double = 0
    var y: Double = 0
    var z: Double = 0
    var nums: [Double] = []
    var heading: Double = 0
    var direction: String = "North"
    var currentCity:String = "San Jose"
    //    motionManager.stopMagnetometerUpdates()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if motionManager.isMagnetometerAvailable {
            print("We can detect device direction")
            startReadingMotionData()
        }
        else {
            print("We cannot detect device direction")
        }
            locationView.isHidden = true
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func motionEnded(_ motion: UIEventSubtype, with event: UIEvent?) {
        if (motion == .motionShake) {
          
            let city = newCity(quad: direction)
            displayData(city: city)
        }
    }
    
    func newCity (quad: String) -> [String : String] {
        if quad == "North" {
            var indx = Int(arc4random_uniform(5))
            while north[indx]["name"] == currentCity {
                indx = Int(arc4random_uniform(5)+1)
            }
                return north[indx]
            
        } else if quad == "South" {
            var indx = Int(arc4random_uniform(5))
            while south[indx]["name"] == currentCity {
                indx = Int(arc4random_uniform(5)+1)
            }
            return south[indx]
        }  else if quad == "East" {
            var indx = Int(arc4random_uniform(5))
            while east[indx]["name"] == currentCity {
                indx = Int(arc4random_uniform(5)+1)
            }
             return east[indx]
        } else if quad == "West" {
            var indx = Int(arc4random_uniform(5))
            while west[indx]["name"] == currentCity {
                indx = Int(arc4random_uniform(5)+1)
            }
            return west[indx]
        }
        
        return ["":""];
    }
    
    func startReadingMotionData() {
        motionManager.magnetometerUpdateInterval = 0.5
        motionManager.showsDeviceMovementDisplay = true
        
        motionManager.startMagnetometerUpdates(to: opQueue) {
            (data: CMMagnetometerData?, error: Error?) in
            
            if let magnetometerData = data {
                print(magnetometerData)
                self.x = magnetometerData.magneticField.x
                self.y = magnetometerData.magneticField.y
                self.z = magnetometerData.magneticField.z
                print(" x: \(self.x), y: \(self.y), z: \(self.z)")
                self.nums = [self.x, self.y, self.z]
                
                if self.y > 145 {
                    self.direction = "North"
                } else if self.y > 120 && self.x > 0 {
                    self.direction = "West"
                }
                else if self.y < 120 && self.x < 0 {
                    self.direction = "East"

                }
                else {
                    self.direction = "South"
                }
            
            }
                
            else {
                print("Device motion is nil.")
            }
            
        }
        //        motionManager.stopMagnetometerUpdates()
    }

    
    

}

