//
//  ViewController.swift
//  weatherApp
//
//  Created by Dinesh Sharma on 19/11/22.
//

import UIKit
import CoreLocation

class weatherViewController: UIViewController {
    
    @IBOutlet var backgroundView: UIView!
    
    @IBOutlet weak var locationName: UILabel!
    
    @IBOutlet weak var searchTextField: UITextField!
    
    @IBOutlet weak var locationTemp: UILabel!
    @IBOutlet weak var locationImage: UIImageView!
    @IBOutlet weak var descLabel: UILabel!
    
    var weatherManager = WeatherManager()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchTextField.delegate = self
        weatherManager.delegate = self
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }

}


//MARK: - UITextFieldDelegate

extension weatherViewController: UITextFieldDelegate {
    
    @IBAction func searchTapped(_ sender: Any) {
        searchTextField.endEditing(true)
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(searchTextField.text != nil){
            return true
        }else {
            searchTextField.placeholder = "Type Something"
            return false
        }
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.endEditing(true)
        return true
    }
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        let cityName = textField.text!
        weatherManager.fetchWeather(cityName: cityName)
//        searchTextField.text = ""
        
    }
}

//MARK: - CLLocationManagerDelegate

extension weatherViewController: CLLocationManagerDelegate {
    
    @IBAction func getCurrentLocationPressed(_ sender: Any) {
        locationManager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
            weatherManager.fetchWeather(lat: lat, lon: lon)
        }
        
    }
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
    
}

//MARK: - WeatherManagerDelegate


extension weatherViewController: WeatherManagerDelegate {
    
    func updateUI(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.descLabel.text = weather.description
            self.locationTemp.text = weather.tempString
            self.locationName.text = weather.name
            print(weather.conditionImage)
            self.locationImage.image = UIImage(systemName: weather.conditionImage)
            
        }
    }
    
}





