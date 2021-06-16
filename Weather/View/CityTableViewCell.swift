//
//  CityTableViewCell.swift
//  Weather
//
//  Created by Олег Савельев on 12.06.2021.
//

import UIKit
import SwiftSVG

class CityTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherImageView: UIImageView!
 
   // MARK: Init cell
    func initCell(item: Weather){
        updateView()
        loadIcon(url: item)
        self.cityNameLabel.text = item.cityName
        self.tempLabel.text = item.tempString
    }
    
    
    //MARK: Constraints Cell
    func updateView(){

        cityNameLabel.translatesAutoresizingMaskIntoConstraints = false
        tempLabel.translatesAutoresizingMaskIntoConstraints = false
        weatherImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            cityNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            cityNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            
            tempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            tempLabel.trailingAnchor.constraint(equalTo: weatherImageView.leadingAnchor, constant: -40),
            
            weatherImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            weatherImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            weatherImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            weatherImageView.heightAnchor.constraint(equalToConstant: 50),
            weatherImageView.widthAnchor.constraint(equalTo: weatherImageView.heightAnchor)
        ])
    }
    
    //MARK: -Load image
    func loadIcon(url: Weather){
        guard let iconUrl = URL(string: iconUrlY + url.icon + ".svg") else { return }
        DispatchQueue.global().async {
            let svgData = try! Data(contentsOf: iconUrl)
    
            DispatchQueue.main.async {
                let add = UIView(SVGData: svgData){ image in
                    image.resizeToFit(self.weatherImageView.bounds)
                }
                self.weatherImageView.addSubview(add)
            }
        }
    }
}
