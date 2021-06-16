//
//  CityViewController.swift
//  Weather
//
//  Created by Олег Савельев on 13.06.2021.
//

import UIKit

class CityViewController: UIViewController {
    
    //MARK: -Variables
    var cities: [Weather] = []
    var cityData: Weather?
    var saveCompletion: (() -> Void)?
    
    
    //MARK: - Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var feelsLikeLabel: UILabel!
    @IBOutlet weak var minTempLabel: UILabel!
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var windLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var addButton: UIButton!
    
    //MARK: - Actions
    @IBAction func addButton(_ sender: Any) {
        guard let data = cityData else { return }
        
        let mainVC = storyboard?.instantiateViewController(identifier: "Table") as! CitiesViewController
        mainVC.cities.insert(data, at: 0)

        
        print(cities.count)

        dismiss(animated: true, completion: saveCompletion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        installView()
    }
    
    //MARK: - UpdateView
    func installView(){
        guard let data = cityData else { return }
        
        cityNameLabel.text = data.cityName
        tempLabel.text = data.tempString
        conditionLabel.text = data.conditions
        feelsLikeLabel.text = data.feelsLikeString
        minTempLabel.text = data.minTempString
        maxTempLabel.text = data.maxTempString
        windLabel.text = data.windString
        humidityLabel.text = data.humidityString
        pressureLabel.text = data.pressureString
        loadIcon(url: data)
    }
    
    func loadIcon(url: Weather){
        guard let iconUrl = URL(string: iconUrlY + url.icon + ".svg") else { return }
        DispatchQueue.global().async {
            let svgData = try! Data(contentsOf: iconUrl)
            DispatchQueue.main.async {
                let add = UIView(SVGData: svgData){ image in
                    image.resizeToFit(self.imageView.bounds)

                }
                self.imageView.addSubview(add)
            }
            
        }
        
        }

}
