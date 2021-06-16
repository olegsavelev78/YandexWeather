//
//  CitiesViewController.swift
//  Weather
//
//  Created by Олег Савельев on 12.06.2021.
//

import UIKit
import CoreLocation

class CitiesViewController: UIViewController {
    
    //MARK: - Variables
    var network = Network()
    var cities: [Weather] = []
    var indicator = UIActivityIndicatorView()
    
    //MARK: - Outlets
    @IBOutlet weak var citySearchBar: UISearchBar!
    @IBOutlet weak var citiesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getWeather()
    }

    //MARK: - Get weather
    func getWeather(){
        activityIndicator()
        indicator.startAnimating()
        Network().getCitesWeather(cities: citiesArray) { [weak self] (weather)  in
            guard let self = self else { return }
            self.cities.append(weather)
            DispatchQueue.main.async {
                self.citiesTableView.reloadData()
                self.citiesTableView.isHidden = false
                self.indicator.stopAnimating()
            }
            
        }
    }

}

//MARK: - UITableViewDataSource
extension CitiesViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "City") as! CityTableViewCell
        let item = cities[indexPath.row]
        cell.initCell(item: item)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citiesTableView.deselectRow(at: indexPath, animated: true)
        let cityVC = storyboard?.instantiateViewController(identifier: "City") as! CityViewController
        cityVC.cityData = cities[indexPath.row]
        self.present(cityVC, animated: true, completion: nil)
    }
    
    //MARK: -Delete Cell
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row)
            citiesTableView.deleteRows(at: [indexPath], with: .left)
            citiesTableView.reloadData()
        }
    }
    
}
