//
//  ViewController.swift
//  WeatherAPI
//
//  Created by A Khairini on 06/08/20.
//  Copyright © 2020 Infinite Learning ADA. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var labelTemp: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchWeatherApi()
    }
    
    func fetchWeatherApi() {
        guard let weatherUrl = URL(string: "https://samples.openweathermap.org/data/2.5/weather?q=London,uk&appid=439d4b804bc8187953eb36d2a8c26a02") else{return}
        URLSession.shared.dataTask(with: weatherUrl) { (data, respone, error) in
            guard let data = data else {return}
            do {
                let decoder = JSONDecoder()
                let weatherData = try decoder.decode(WeatherAPI.self, from: data)
                
                let temp = weatherData.main?.temp ?? 0
                
                DispatchQueue.main.async {
                    self.labelTemp.text = "\(temp)°"
                    
                }
            }
            catch let err {
                print("Err", err)
            }
        }.resume()
    }
}

struct WeatherAPI: Codable {
    let main: Main?
    
    private enum CodingKeys: String, CodingKey {
        case main
    }
}

struct Main: Codable{
    let temp: Float?

    
    private enum CodingKeys: String, CodingKey {
        case temp
    }
}



