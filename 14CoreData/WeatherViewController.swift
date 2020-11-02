//
//  WeatherViewController.swift
//  14CoreData
//
//  Created by Sergey Lobanovskiy on 02.11.2020.
//

import UIKit

class WeatherViewController: UIViewController {

    @IBOutlet weak var cityLabel: UILabel!
    
    @IBOutlet weak var digitalLabel: UILabel!
    
    var weatherFeed: WeatherFeed!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if Persistance.shared.weaher != nil {
            digitalLabel.text = Persistance.shared.weaher!
        }
        let loder = WeatherLoader()
        loder.delegete = self
        loder.loadWeather()
        Persistance.shared.weaher = digitalLabel.text

    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Persistance.shared.weaher = digitalLabel.text
    }
}
extension WeatherViewController: WeatherDelegate{
    func loaded(weather: WeatherFeed){
        self.weatherFeed = weather
        cityLabel.text = weatherFeed!.name
        digitalLabel.text = String(format: "%.0f", weatherFeed.main.temp)
    }
}
